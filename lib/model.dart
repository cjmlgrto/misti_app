class Device {
  // The local device name
  static const String name = "My_Misti_01";

  // myMistiService
  static const String service = "20B10020-E8F2-537E-4F6C-D104768A1214";

  // The number of drops recorded by the device
  static const String dosageCharacteristic = "MST-C01-A";

  // The battery level of the device from 0-100
  static const String batteryLevelCharacteristic = "MST-C02-A";

  // The theoretical number of drops left in the bottle
  static const String dispenseCharacteristic = "MST-C03-A";

  // Reset function
  static const String resetCharacteristic = "MST-C04-A";
}

enum DeviceState { connected, connecting, disconnected, off }

enum UsageState { none, min, mid, max }
