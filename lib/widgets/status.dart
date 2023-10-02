import 'package:flutter/material.dart';
import 'package:app_template/constants.dart';

class DeviceStatus extends StatelessWidget {
  final bool isConnected;
  final int batteryLevel;

  final void Function() onConnectPressed;
  final void Function() onHelpPressed;

  const DeviceStatus(
      {super.key,
      required this.isConnected,
      required this.batteryLevel,
      required this.onConnectPressed,
      required this.onHelpPressed});

  Column titleLockup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Device Status",
                style: TextStyles.subtitle
                    .copyWith(color: AppColors.accentPrimary)),
            ElevatedButton(
                onPressed: onHelpPressed,
                style: ButtonStyles.buttonMiniPrimary,
                child: const Text("Help"))
          ],
        ),
        const Text("Misti Mask", style: TextStyles.title)
      ],
    );
  }

  Column actionLockup() {
    return Column(children: [
      Container(
        width: double.infinity,
        color: Colors.transparent,
        child: ElevatedButton(
          onPressed: onConnectPressed,
          style: ButtonStyles.buttonPrimary,
          child: const Text("Connect"),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Not Connected",
              style:
                  TextStyles.caption.copyWith(color: AppColors.accentPrimary),
            )
          ],
        ),
      )
    ]);
  }

  Column emptyLockup() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 48),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Connecting...",
              style:
                  TextStyles.caption.copyWith(color: AppColors.accentPrimary),
            )
          ],
        ),
      )
    ]);
  }

  Column batteryLockup() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Flexible(
                  flex: batteryLevel,
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                        color: AppColors.accentPrimary,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  )),
              Flexible(
                  flex: (100 - batteryLevel), child: const SizedBox.shrink())
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$batteryLevel% Battery",
              style:
                  TextStyles.caption.copyWith(color: AppColors.accentPrimary),
            ),
            Text(
              "Connected",
              style:
                  TextStyles.caption.copyWith(color: AppColors.accentPrimary),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.surfacePrimary,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: titleLockup()),
            (isConnected ? batteryLockup() : actionLockup())
          ],
        ),
      ),
    );
  }
}
