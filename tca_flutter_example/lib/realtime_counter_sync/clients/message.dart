part of '../realtime_counter_sync.dart';

final class Message {
  final String action;
  final String deviceId;
  final String id;

  const Message({
    required this.action, //
    required this.deviceId,
    required this.id,
  });

  @override
  int get hashCode => action.hashCode ^ deviceId.hashCode ^ id.hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return identical(other, this) ||
        (other is Message &&
            other.action == action &&
            other.deviceId == deviceId &&
            other.id == id);
  }

  @override
  String toString() {
    return "Message: $id, $action";
  }
}
