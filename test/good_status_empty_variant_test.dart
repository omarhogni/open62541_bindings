// Regression test for a whole-process SIGSEGV on a spec-legal server answer:
// status GOOD with an EMPTY variant ("the attribute exists and carries no
// value", OPC UA Part 4).
//
// Symptom
//   An empty variant has `type == NULL` and `data == NULL`. Three client
//   paths dereferenced those pointers natively without checking:
//     * Client.readAttribute — every case of its attribute switch
//       (`value!.data.cast<...>().ref`, and the DataTypeDefinition case's
//       `value!.type.ref.typeId`),
//     * the monitored-items notification callback — same switch shape, for a
//       GOOD sample carrying no value (a Bad sample without a value was
//       already guarded), and
//     * _variantToValueAutoSchema — `data.type.ref.typeId` on its first line.
//   The result is a native SIGSEGV (si_addr = a small struct-field offset),
//   killing the whole process — NOT a catchable Dart exception.
//
// Who answers like this in the wild
//   python-asyncua answers Good+empty for the DataTypeDefinition attribute of
//   all 497 base DataType nodes of its standard address space. TwinCAT
//   answers BadAttributeIdInvalid instead — which readAttribute already
//   tolerates — so the crash stays latent against TwinCAT and kills the
//   client against asyncua (and any other server, simulator or gateway that
//   picks the Good+empty shape).
//
// Fixture
//   The Dart Server wrapper cannot produce the shape (addVariableNode
//   requires a value; valueToVariant throws on a null DynamicValue), so the
//   server here is built from the raw bindings: a variable node added with
//   UA_VariableAttributes_default keeps the default EMPTY value variant, and
//   open62541 then answers Value reads and monitor notifications for it with
//   status Good and no payload.
//
// Red/green
//   At the parent commit of the fix, `dart test test/good_status_empty_variant_test.dart`
//   dies with SIGSEGV before any expectation runs (the harness reports the
//   suite as crashed). With the fix, the empty answer is treated exactly like
//   the already-tolerated BadAttributeIdInvalid path: the attribute is absent,
//   the VM stays alive.

import 'dart:async';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:test/test.dart';

import 'package:open62541/open62541.dart';
import 'package:open62541/src/third_party/open62541.g.dart' as raw;
import 'package:open62541/src/ua_allocation.dart' show ua_calloc, ua_malloc;
import 'common.dart' show freeTcpPort, setupClient;

final emptyNodeId = NodeId.fromString(1, "the.empty");

void main() {
  late ffi.Pointer<raw.UA_Server> server;
  Timer? serverTimer;

  Future<int> startRawServer() async {
    final port = await freeTcpPort();

    final config = ua_calloc<raw.UA_ServerConfig>();
    config.ref.logging = raw.UA_Log_Stdout_new(raw.UA_LogLevel.UA_LOGLEVEL_ERROR);
    final cfgStatus = raw.UA_ServerConfig_setMinimal(config, port, ffi.nullptr);
    expect(cfgStatus, equals(UA_STATUSCODE_GOOD), reason: 'server config must build');
    server = raw.UA_Server_newWithConfig(config);

    // The node under test: UA_VariableAttributes_default carries an EMPTY
    // value variant, and no value is ever written — so the server answers
    // Value reads with status Good and an empty variant.
    final attr = raw.UA_VariableAttributes_new();
    attr.ref = raw.UA_VariableAttributes_default;
    final name = raw.UA_QUALIFIEDNAME(1, "the.empty".toNativeUtf8(allocator: ua_malloc).cast());
    final addStatus = raw.UA_Server_addVariableNode(
      server,
      emptyNodeId.toRaw(),
      NodeId.fromNumeric(0, raw.UA_NS0ID_OBJECTSFOLDER).toRaw(),
      NodeId.fromNumeric(0, raw.UA_NS0ID_ORGANIZES).toRaw(),
      name,
      NodeId.fromNumeric(0, raw.UA_NS0ID_BASEDATAVARIABLETYPE).toRaw(),
      attr.ref,
      ffi.nullptr,
      ffi.nullptr,
    );
    raw.UA_VariableAttributes_delete(attr);
    expect(addStatus, equals(UA_STATUSCODE_GOOD), reason: 'valueless variable node must be added');

    final startStatus = raw.UA_Server_run_startup(server);
    expect(startStatus, equals(UA_STATUSCODE_GOOD), reason: 'server must start');
    serverTimer = Timer.periodic(Duration(milliseconds: 10), (_) {
      raw.UA_Server_run_iterate(server, false);
    });
    return port;
  }

  void stopRawServer() {
    serverTimer?.cancel();
    serverTimer = null;
    raw.UA_Server_run_shutdown(server);
    raw.UA_Server_delete(server);
  }

  test('readAttribute of a Good empty Value answers "attribute absent", not SIGSEGV', () async {
    final port = await startRawServer();
    final client = await setupClient(port);

    final result = await client.readAttribute({
      emptyNodeId: [AttributeId.UA_ATTRIBUTEID_VALUE],
    });

    // If the VM is still alive, this runs — proving no SIGSEGV.
    expect(1 + 1, equals(2), reason: 'VM must still be alive after the read');
    // The empty answer is treated like the tolerated BadAttributeIdInvalid
    // path: the attribute is absent from the result.
    expect(result[emptyNodeId]?.isNull ?? true, isTrue, reason: 'an empty Value must decode to no value');

    await client.delete();
    stopRawServer();
  }, timeout: Timeout(Duration(seconds: 20)));

  test('monitoring a Good empty Value delivers a null DynamicValue, not SIGSEGV', () async {
    final port = await startRawServer();
    final client = await setupClient(port);

    final subscriptionId = await client.subscriptionCreate(requestedPublishingInterval: Duration(milliseconds: 50));

    final values = <DynamicValue>[];
    final errors = <Object>[];
    final subscription = client
        .monitor(emptyNodeId, subscriptionId, samplingInterval: Duration(milliseconds: 50))
        .listen(values.add, onError: errors.add);

    // The initial notification samples the valueless variable: status Good,
    // no payload. Pre-fix that notification killed the process.
    final start = DateTime.now();
    while (values.isEmpty && errors.isEmpty && DateTime.now().difference(start) < Duration(seconds: 5)) {
      await Future.delayed(Duration(milliseconds: 20));
    }

    expect(2 + 2, equals(4), reason: 'VM must still be alive after the notification');
    expect(errors, isEmpty, reason: 'a Good empty sample is not an error');
    expect(values, isNotEmpty, reason: 'the Good empty sample must still be delivered');
    expect(values.first.isNull, isTrue, reason: 'no payload decodes to a null DynamicValue');

    await subscription.cancel();
    await client.delete();
    stopRawServer();
  }, timeout: Timeout(Duration(seconds: 20)));
}
