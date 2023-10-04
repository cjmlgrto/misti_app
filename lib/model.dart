class Device {
  // The local device name
  static const String name = "My_Misti_01";

  // myMistiService
  static const String service = "20B10020-E8F2-537E-4F6C-D104768A1214";

  // The number of drops recorded by the device
  static const String dosageCharacteristic =
      "20B10022-E8F2-537E-4F6C-D104768A1214";

  // The battery level of the device from 0-100
  static const String batteryLevelCharacteristic =
      "20B10023-E8F2-537E-4F6C-D104768A1214";

  // The theoretical number of drops left in the bottle
  static const String dispenseCharacteristic =
      "20B10021-E8F2-537E-4F6C-D104768A1214";

  // Reset function
  static const String resetCharacteristic =
      "20B10028-E8F2-537E-4F6C-D104768A1214";
}

enum DeviceState { connected, connecting, disconnected, off }

enum UsageState { none, zero, one, two, three, four, five }
