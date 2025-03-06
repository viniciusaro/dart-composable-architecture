import 'dart:async';
import 'dart:io';

import '../device_id_client.dart';

part 'message.dart';
part 'stream.dart';
part 'udp_multicast_service.dart';

var messageBrokerClient = udpMulticastMessageBrokerClient;

final class MessageBrokerClient {
  Stream<Message> Function() listen;
  Future<void> Function(String) publish;
  MessageBrokerClient({required this.listen, required this.publish});
}

final udpMulticastMessageBrokerClient = MessageBrokerClient(
  listen: () async* {
    final deviceId = await deviceIdClient.getDeviceId();
    yield* udpMulticastService
        .listen()
        .map(MessageFromUdpMulticast.fromMulticastMessage)
        .where((msg) => msg.deviceId != deviceId)
        .realDistinct();
  },
  publish: (action) async {
    final deviceId = await deviceIdClient.getDeviceId();
    udpMulticastService.send(
      Message(
        action: action,
        deviceId: deviceId,
        id: DateTime.now().toIso8601String(), //
      ).toMulticastMessage(),
    );
  },
);

final unimplementedMessageBrokerClient = MessageBrokerClient(
  listen: () => throw Exception("unimplemented"),
  publish: (_) => throw Exception("unimplemented"),
);

final emptyMessageBrokerClient = MessageBrokerClient(
  listen: () => Stream.empty(),
  publish: (_) async => {},
);

extension MessageFromUdpMulticast on Message {
  static Message fromMulticastMessage(String msg) {
    final fields = msg.split(",");
    return Message(action: fields[0], deviceId: fields[1], id: fields[2]);
  }

  String toMulticastMessage() => "$action,$deviceId,$id";
}
