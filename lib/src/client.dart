import 'dart:async';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'generated/open62541_bindings.dart' as raw;
import 'library.dart';

class ClientState {
  int channelState;
  int sessionState;
  int connectStatus;
  ClientState(
      {required this.channelState,
      required this.sessionState,
      required this.connectStatus});
}

class ClientConfig {
  ClientConfig(this._clientConfig) {
    // Intercept callbacks
    final nativeState = ffi.NativeCallable<
            ffi.Void Function(
                ffi.Pointer<raw.UA_Client> client,
                ffi.Int32 channelState,
                ffi.Int32 sessionState,
                raw.UA_StatusCode connectStatus)>.isolateLocal(
        (ffi.Pointer<raw.UA_Client> client, int channelState, int sessionState,
                int connectStatus) =>
            _stateStream.add(ClientState(channelState: channelState, sessionState: sessionState, connectStatus: connectStatus)));
    _clientConfig.ref.stateCallback = nativeState.nativeFunction;
  }
  Stream<ClientState> get stateStream => _stateStream.stream;
  // Private interface

  //TODO: Subscription inactivity callback & stream

  final ffi.Pointer<raw.UA_ClientConfig> _clientConfig;
  final StreamController<ClientState> _stateStream =
      StreamController<ClientState>.broadcast();
}

class Client {
  Client() {
    _client = Open62541Singleton().lib.UA_Client_new();
    ffi.Pointer<raw.UA_ClientConfig> clientConfigPointer =
        Open62541Singleton().lib.UA_Client_getConfig(_client);

    //TODO: Inject some sort of state to locate the streams inside of the callbacks
    // clientConfigPointer.ref.clientContext = ffi.Pointer<ffi.Void>.fromAddress(ffi.Native.addressOf(this).address);
    _clientConfig = ClientConfig(clientConfigPointer);
  }

  ClientConfig get config => _clientConfig;

  int connect(String url) {
    ffi.Pointer<ffi.Char> urlPointer = url.toNativeUtf8().cast();
    return Open62541Singleton().lib.UA_Client_connect(_client, urlPointer);
  }

  void close() {
    print('Closed connection');
    Open62541Singleton().lib.UA_Client_delete(_client);
  }

  late ffi.Pointer<raw.UA_Client> _client;
  late ClientConfig _clientConfig;
}
