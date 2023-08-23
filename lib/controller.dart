import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'package:app_template/view.dart';
import 'package:app_template/model.dart';

class BluetoothController extends StatelessWidget {
  const BluetoothController({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      home: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return const DeviceScanner();
            }
            return const StatusScreen(text: "No Device Connected");
          }),
    );
  }
}

// Device Scanner Screen
// ------------------------------------------------------------
class DeviceScanner extends StatelessWidget {
  const DeviceScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterBlue.instance.startScan(timeout: const Duration(seconds: 4));
    FlutterBlue.instance.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (r.device.name == Device.name) {
          FlutterBlue.instance.stopScan();
          r.device.connect();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DeviceScreen(device: r.device)));
        }
      }
    });

    FlutterBlue.instance.stopScan();

    return const StatusScreen(text: "Connecting...");
  }
}

// Device Screen
// ------------------------------------------------------------
class DeviceScreen extends StatefulWidget {
  final BluetoothDevice device;

  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  late Timer _everySecond;

  int exampleCharacteristic = 0;

  @override
  void initState() {
    super.initState();

    _everySecond = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        refresh();
      });
    });
  }

  Future refresh() async {
    widget.device.discoverServices().then((services) => {
          services.forEach((service) async {
            if (service.uuid.toString() == "".toLowerCase()) {
              for (BluetoothCharacteristic c in service.characteristics) {
                List<int> value = await c.read();

                // exampleCharacteristic
                if (c.uuid.toString() ==
                    Device.exampleCharacteristic.toLowerCase()) {
                  setState(() {
                    exampleCharacteristic = value[0];
                  });
                }
              }
            }
          })
        });

    await Future.delayed(const Duration(seconds: 1));
  }

  void reset() async {
    List<BluetoothService> services = await widget.device.discoverServices();

    services.forEach((service) async {
      var characteristics = service.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        // Reset Characteristic
        if (c.uuid.toString() == Device.resetCharacteristic.toLowerCase()) {
          c.write([0]);
        }
      }
    });

    setState(() {
      exampleCharacteristic = 0;
    });
  }

  void exit() {
    widget.device.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return StatusScreen(text: "exampleCharacteristic: $exampleCharacteristic");
  }
}
