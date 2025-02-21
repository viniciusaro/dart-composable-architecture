part of '../realtime_counter_sync.dart';

final udpMulticastService = UdpMulticastService._();

class UdpMulticastService {
  static const String multicastAddress = "239.1.1.1"; // Multicast IP range
  static const int port = 5000;

  UdpMulticastService._();

  RawDatagramSocket? _socket;

  Stream<String> listen() async* {
    _socket = await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      port,
      reuseAddress: true,
      reusePort: true,
    );
    _socket!.multicastHops = 1;
    _socket!.joinMulticast(InternetAddress(multicastAddress));

    final controller = StreamController<String>(
      onCancel: () {
        _socket?.close();
      },
    );

    _socket!.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        final datagram = _socket!.receive();
        if (datagram != null) {
          final string = String.fromCharCodes(datagram.data);
          controller.add(string);
        }
      }
    });

    yield* controller.stream;
  }

  void send(String msg) {
    final message = msg.codeUnits;
    _socket?.send(message, InternetAddress(multicastAddress), port);
  }
}
