// TODO: Put public facing types in this file.
// import 'dart:ffi';
import 'dart:io';

import 'package:open62541_bindings/src/client.dart';
//
// import 'client.dart';
//
// late open62541 lib;
//
// void stateCallback(Pointer<UA_Client> client, int channelState, int sessionState, int connectStatus) {
//   switch (channelState) {
//     case UA_SecureChannelState.UA_SECURECHANNELSTATE_CLOSED:
//       print('Channel disconnected');
//       break;
//     case UA_SecureChannelState.UA_SECURECHANNELSTATE_HEL_SENT:
//       print('Channel Waiting for ack');
//       break;
//     case UA_SecureChannelState.UA_SECURECHANNELSTATE_OPN_SENT:
//       print('Channel WAITING FOR OPN RESPONSE');
//       break;
//     case UA_SecureChannelState.UA_SECURECHANNELSTATE_OPEN:
//       print('Channel A Secure channel to server is open');
//       break;
//   }
//
//   switch (sessionState) {
//     case UA_SessionState.UA_SESSIONSTATE_ACTIVATED:
//       print('Session activated');
//       break;
//     case UA_SessionState.UA_SESSIONSTATE_CLOSED:
//       print('Session closed');
//       break;
//     default:
//       break;
//   }
// }

// void deleteCallback(Pointer<UA_Client> client, int subscriptionId, Pointer<Void> subscriptionContext) {
//   print('Subscription deleted $subscriptionId');
// }
//
// void handlerCurrentTimeChanged(Pointer<UA_Client> client, int subId, Pointer<Void> subContext, int monId, Pointer<Void> monContext, Pointer<UA_DataValue> value) {
//   print('Current time changed');
//   // if (lib.UA_Variant_hasScalarType(value.ref.value, UA_TYPES[UA_TYPES_DATETIME])) {}
// }
//
// void subscriptionInactivityCallback(Pointer<UA_Client> client, Pointer<UA_UInt32> subId, Pointer<Void> subContext, Pointer<UA_UInt32> monId, Pointer<Void> monContext, UA_StatusCode status) {
//   print('Subscription inactivity callback ${subId.value}');
// }

/// Checks if you are awesome. Spoiler: you are.
int main() {
  Client c = Client();
  var config = c.config;

  c.config.stateStream.listen((event) {
    print('Channel state: ${event.channelState}');
  });
  // //clientConfig.ref.subscriptionInactivityCallback = Pointer.fromFunction(subscriptionInactivityCallback);

  // // Pointer<Pointer<UA_EndpointDescription>> endpointDescription = nullptr;
  String endpointUrl = 'opc.tcp://localhost:4840';
  var statusCode = c.connect(endpointUrl);
  print('Endpoint url: $endpointUrl');
  if (statusCode == 0) {
    print('Client connected!');
  } else {
    c.close();
    exit(-1);
  }

  // UA_NodeId currentTimeNode = lib.UA_NODEID_NUMERIC(0, UA_NS0ID_SERVER_SERVERSTATUS_CURRENTTIME);
  // for (int i = 0; i < 10; i++) {
  //   Pointer<UA_Variant> value = malloc<UA_Variant>();
  //   lib.UA_Variant_init(value);
  //   var retvalue = lib.UA_Client_readValueAttribute(client, currentTimeNode, value);
  //   if (retvalue == UA_STATUSCODE_GOOD) {
  //     // lib.UA_Variant_hasScalarType(value, lib.UA_TYPES[UA_TYPES_DATETIME]); TODO: Find figure out how to do this
  //     int val = value.ref.data.cast<UA_DateTime>().value;
  //     UA_DateTimeStruct dts = lib.UA_DateTime_toStruct(val);
  //     DateTime dt = DateTime(dts.year, dts.month, dts.day, dts.hour, dts.min, dts.sec, dts.milliSec);
  //     print(dt);
  //   } else {
  //     print('Failed to read current time');
  //     lib.UA_Client_delete(client);
  //     exit(-1);
  //   }
  //   lib.UA_Variant_clear(value);
  //   malloc.free(value);
  //   sleep(Duration(seconds: 1));
  // }

  // Pointer<UA_CreateSubscriptionRequest> request = malloc<UA_CreateSubscriptionRequest>();
  // lib.UA_CreateSubscriptionRequest_init(request);
  // request.ref.requestedPublishingInterval = 500.0;
  // request.ref.requestedLifetimeCount = 10000;
  // request.ref.requestedMaxKeepAliveCount = 10;
  // request.ref.maxNotificationsPerPublish = 0;
  // request.ref.publishingEnabled = true;
  // request.ref.priority = 0;

  // UA_CreateSubscriptionResponse response =
  //     lib.UA_Client_Subscriptions_create(client, request.ref, nullptr, nullptr, Pointer.fromFunction<Void Function(Pointer<UA_Client>, Uint32, Pointer<Void>)>(deleteCallback));
  // if (response.responseHeader.serviceResult == UA_STATUSCODE_GOOD) {
  //   print("Subscription created id: ${response.subscriptionId}");
  // } else {
  //   print("Failed to create subscription");
  //   exit(-1);
  // }
  // Pointer<UA_MonitoredItemCreateRequest> monRequest = malloc<UA_MonitoredItemCreateRequest>();
  // lib.UA_MonitoredItemCreateRequest_init(monRequest);
  // monRequest.ref.itemToMonitor.nodeId = currentTimeNode;
  // monRequest.ref.itemToMonitor.attributeId = UA_AttributeId.UA_ATTRIBUTEID_VALUE;
  // monRequest.ref.requestedParameters.samplingInterval = 250;
  // monRequest.ref.requestedParameters.discardOldest = true;
  // monRequest.ref.requestedParameters.queueSize = 1;

  // UA_MonitoredItemCreateResult monResponse = lib.UA_Client_MonitoredItems_createDataChange(client, response.subscriptionId, UA_TimestampsToReturn.UA_TIMESTAMPSTORETURN_BOTH, monRequest.ref, nullptr,
  //     Pointer.fromFunction<Void Function(Pointer<UA_Client>, Uint32, Pointer<Void>, Uint32, Pointer<Void>, Pointer<UA_DataValue>)>(handlerCurrentTimeChanged), nullptr);
  // if (monResponse.statusCode == UA_STATUSCODE_GOOD) {
  //   print('Monitored item created id: ${monResponse.monitoredItemId}');
  // } else {
  //   print('Failed to create monitored item');
  //   lib.UA_Client_delete(client);
  //   exit(-1);
  // }

  // print('setup complete');

  // var startTime = DateTime.now().millisecondsSinceEpoch;
  // while (true) {
  //   lib.UA_Client_run_iterate(client, 100);
  //   if (startTime < DateTime.now().millisecondsSinceEpoch - 30000) {
  //     break;
  //   }
  // }

  // // calloc.free(endpointUrl);
  // lib.UA_Client_delete(client);
  print('Exiting');
  return 0;
}
