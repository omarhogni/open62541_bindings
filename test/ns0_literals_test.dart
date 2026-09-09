// The namespace-0 identifiers on NodeId are written as literals in
// node_id_core.dart, because reading them from the generated bindings is
// exactly what would pull `dart:ffi` into the one file that must not have it.
//
// This test is the price of that: every literal is checked against the
// generated constant it stands in for, so a regenerated binding that moves a
// number fails here instead of silently addressing the wrong node at runtime.
// It is a native test on purpose — it needs the bindings to compare against.

import 'package:test/test.dart';

import 'package:open62541/open62541_types.dart';
import 'package:open62541/src/third_party/open62541.g.dart' as raw;

void main() {
  final expected = <String, ({NodeId actual, int generated})>{
    'nullId': (actual: NodeId.nullId, generated: 0),
    'boolean': (actual: NodeId.boolean, generated: raw.UA_NS0ID_BOOLEAN),
    'sbyte': (actual: NodeId.sbyte, generated: raw.UA_NS0ID_SBYTE),
    'byte': (actual: NodeId.byte, generated: raw.UA_NS0ID_BYTE),
    'int16': (actual: NodeId.int16, generated: raw.UA_NS0ID_INT16),
    'uint16': (actual: NodeId.uint16, generated: raw.UA_NS0ID_UINT16),
    'int32': (actual: NodeId.int32, generated: raw.UA_NS0ID_INT32),
    'uint32': (actual: NodeId.uint32, generated: raw.UA_NS0ID_UINT32),
    'int64': (actual: NodeId.int64, generated: raw.UA_NS0ID_INT64),
    'uint64': (actual: NodeId.uint64, generated: raw.UA_NS0ID_UINT64),
    'float': (actual: NodeId.float, generated: raw.UA_NS0ID_FLOAT),
    'double': (actual: NodeId.double, generated: raw.UA_NS0ID_DOUBLE),
    'uastring': (actual: NodeId.uastring, generated: raw.UA_NS0ID_STRING),
    'datetime': (actual: NodeId.datetime, generated: raw.UA_NS0ID_DATETIME),
    'nodeId': (actual: NodeId.nodeId, generated: raw.UA_NS0ID_NODEID),
    'localizedText': (actual: NodeId.localizedText, generated: raw.UA_NS0ID_LOCALIZEDTEXT),
    'structure': (actual: NodeId.structure, generated: raw.UA_NS0ID_STRUCTURE),
    'structureDefinition': (actual: NodeId.structureDefinition, generated: raw.UA_NS0ID_STRUCTUREDEFINITION),
    'structureDefinitionDefaultBinary': (
      actual: NodeId.structureDefinitionDefaultBinary,
      generated: raw.UA_NS0ID_STRUCTUREDEFINITION_ENCODING_DEFAULTBINARY,
    ),
    'enumDefinitionDefaultBinary': (
      actual: NodeId.enumDefinitionDefaultBinary,
      generated: raw.UA_NS0ID_ENUMDEFINITION_ENCODING_DEFAULTBINARY,
    ),
    'rootFolder': (actual: NodeId.rootFolder, generated: raw.UA_NS0ID_ROOTFOLDER),
    'objectsFolder': (actual: NodeId.objectsFolder, generated: raw.UA_NS0ID_OBJECTSFOLDER),
    'typesFolder': (actual: NodeId.typesFolder, generated: raw.UA_NS0ID_TYPESFOLDER),
    'viewsFolder': (actual: NodeId.viewsFolder, generated: raw.UA_NS0ID_VIEWSFOLDER),
    'hierarchicalReferences': (actual: NodeId.hierarchicalReferences, generated: raw.UA_NS0ID_HIERARCHICALREFERENCES),
    'hasSubtype': (actual: NodeId.hasSubtype, generated: raw.UA_NS0ID_HASSUBTYPE),
  };

  group('NodeId namespace-0 literals match the generated bindings', () {
    expected.forEach((name, pair) {
      test(name, () {
        expect(pair.actual.namespace, 0, reason: '$name must be in namespace 0');
        expect(pair.actual.numeric, pair.generated);
      });
    });
  });

  test('serverStatusCurrentTime is the spec value', () {
    // Not in the generated header under a NS0ID name; pinned to the OPC UA
    // spec value it has always carried.
    expect(NodeId.serverStatusCurrentTime.numeric, 2258);
    expect(NodeId.serverStatusCurrentTime.namespace, 0);
  });
}
