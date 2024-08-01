import 'package:ffi/ffi.dart';

import 'generated/open62541_bindings.dart' as raw;
import 'library.dart';

class NodeId {
  NodeId._internal(this._nodeId);

  factory NodeId.numeric(int nsIndex, int identifier){
      return NodeId._internal(Open62541Singleton().lib.UA_NODEID_NUMERIC(nsIndex, identifier));
  }

  factory NodeId.string(int nsIndex, String chars){
      return NodeId._internal(Open62541Singleton().lib.UA_NODEID_STRING(nsIndex, chars.toNativeUtf8().cast()));
  }

  raw.UA_NodeId _nodeId;

  raw.UA_NodeId get rawNodeId => _nodeId;
}