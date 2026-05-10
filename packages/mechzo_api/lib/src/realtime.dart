import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;

/// Wraps Socket.IO with typed streams per topic.
class MechzoRealtime {
  MechzoRealtime({required this.baseUrl});
  final String baseUrl;

  IO.Socket? _socket;
  final _events = StreamController<RealtimeEvent>.broadcast();

  Stream<RealtimeEvent> get events => _events.stream;

  Future<void> connect(String accessToken) async {
    _socket = IO.io(
      baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': accessToken})
          .disableAutoConnect()
          .build(),
    );
    _socket!.onAny((event, data) {
      _events.add(RealtimeEvent(name: event, data: data));
    });
    _socket!.connect();
  }

  void subscribe(String channel) {
    _socket?.emit('subscribe', {'channel': channel});
  }

  void unsubscribe(String channel) {
    _socket?.emit('unsubscribe', {'channel': channel});
  }

  Future<void> disconnect() async {
    _socket?.dispose();
    _socket = null;
  }
}

class RealtimeEvent {
  RealtimeEvent({required this.name, required this.data});
  final String name;
  final dynamic data;
}
