import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'package:app_template/screens/status.dart';

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
        print(r.device.name);
        if (r.device.name == "Arduino") {
          FlutterBlue.instance.stopScan();
          r.device.connect();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const StatusScreen(text: "Connected")));
        }
      }
    });

    FlutterBlue.instance.stopScan();

    return const StatusScreen(text: "Connecting...");
  }
}
