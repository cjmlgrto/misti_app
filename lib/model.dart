class Device {
  static const String name = "My_Misti_01";
  static const String exampleCharacteristic =
      "20B10023-E8F2-537E-4F6C-D104768A1214";
  static const String resetCharacteristic =
      "20B10028-E8F2-537E-4F6C-D104768A1214";
}

enum DeviceState { connected, connecting, disconnected, off }

enum UsageState { none, min, mid, max }
