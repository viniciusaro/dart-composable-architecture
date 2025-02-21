part of '../realtime_counter_sync.dart';

final class DeviceIdClient {
  Future<String> Function() getDeviceId;

  DeviceIdClient({required this.getDeviceId});
}

DeviceIdClient liveDeviceIdClient = DeviceIdClient(
  getDeviceId: () async {
    final prefs = await SharedPreferences.getInstance();
    final deviceId = prefs.getString("deviceId") ?? Random.secure().nextInt(1000).toString();
    await prefs.setString("deviceId", deviceId);
    return deviceId;
  },
);
