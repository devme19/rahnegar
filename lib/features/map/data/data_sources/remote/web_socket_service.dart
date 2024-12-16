// data/datasources/websocket_service.dart
import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../../model/location_model.dart';



class WebSocketService {
  WebSocketChannel? _channel;
  final StreamController<LocationModel> _locationController = StreamController();
  final String url;
  bool _isConnected = false;
  bool _isReconnecting = false;

  Stream<LocationModel> get locationStream => _locationController.stream;

  WebSocketService({required this.url}) {
    connect();
  }

  void connect() {
    _channel = WebSocketChannel.connect(Uri.parse(url));
    _isConnected = true;
    _channel?.stream.listen((message) {
      final data = jsonDecode(message);
      if (data.containsKey('latitude') && data.containsKey('longitude')) {
        _locationController.add(LocationModel.fromJson(data));
      }else if (data['type'] == 'error') {
      print('Error received: ${data['message']}');
      _locationController.add(LocationModel(latitude: null, longitude: null, type: 'Location not set'));
      }
    }, onError: (error) {
      print('WebSocket error: $error');
      _isConnected = false;
      _tryReconnect();
    }, onDone: () {
      print('WebSocket closed');
      _isConnected = false;
      _tryReconnect();
    });
  }

  void send(String message) {
    if (_isConnected) {
      _channel?.sink.add(message);
    } else {
      print("Cannot send message, WebSocket is not connected.");
    }
  }

  void disconnect() {
    _locationController.close();
    _channel?.sink.close();
    _isConnected = false;
  }

  Future<void> _tryReconnect() async {
    if (_isReconnecting) return;
    _isReconnecting = true;

    // Retry with an exponential backoff (1s, 2s, 4s, etc.)
    int retryDelay = 1;
    while (!_isConnected) {
      print('Attempting to reconnect in $retryDelay seconds...');
      await Future.delayed(Duration(seconds: retryDelay));
      connect();
      retryDelay = (retryDelay * 2).clamp(1, 60); // max delay of 60 seconds
    }

    _isReconnecting = false;
  }
}


// class WebSocketService {
//   WebSocketChannel? _channel;
//   final StreamController<LocationModel> _locationController = StreamController();
//
//   Stream<LocationModel> get locationStream => _locationController.stream;
//   // Stream<LocationModel> get locationStream => _locationController.stream.asBroadcastStream();
//
//   WebSocketService({required String url}){
//     connect(url);
//   }
//   void connect(String url) {
//     _channel = WebSocketChannel.connect(Uri.parse(url));
//     _channel?.stream.listen((message) {
//       final data = jsonDecode(message);
//       if (data.containsKey('latitude') && data.containsKey('longitude')) {
//         _locationController.add(LocationModel.fromJson(data));
//       }
//     }, onError: (error) {
//       print('WebSocket error: $error');
//     }, onDone: () {
//       print('WebSocket closed');
//     });
//   }
//
//   void send(String message) {
//     _channel?.sink.add(message);
//   }
//
//   void disconnect() {
//     _locationController.close();
//     _channel?.sink.close();
//   }
// }

