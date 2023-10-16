import 'package:misti/model.dart';
import 'package:flutter/material.dart';

import 'package:misti/constants.dart';

class UsageStatus extends StatelessWidget {
  final int dispenseCount;

  final void Function() onHelpPressed;

  const UsageStatus(
      {super.key, required this.dispenseCount, required this.onHelpPressed});

  Column titleLockup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Usage Diary",
                style: TextStyles.subtitle
                    .copyWith(color: AppColors.accentSecondary)),
            ElevatedButton(
                onPressed: onHelpPressed,
                style: ButtonStyles.buttonMiniSecondary,
                child: const Text("Guide"))
          ],
        ),
        const Text("Today", style: TextStyles.title)
      ],
    );
  }

  Flexible bar(int count) {
    return Flexible(
        child: Padding(
      padding: EdgeInsets.only(left: (count == 0) ? 0 : 8),
      child: Container(
        height: 40,
        decoration: const BoxDecoration(
            color: AppColors.accentSecondary,
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    ));
  }

  Column usageLockup() {
    var emptyCount = Device.maxDosageCount - dispenseCount;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              for (var i = 0; i < dispenseCount; i++) bar(i),
              for (var i = 0; i < emptyCount; i++)
                const Expanded(child: SizedBox.shrink()),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (dispenseCount == 1)
                  ? "$dispenseCount dose"
                  : "$dispenseCount doses",
              style:
                  TextStyles.caption.copyWith(color: AppColors.accentSecondary),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.surfaceSecondary,
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
                usageLockup()
              ]),
        ),
      ),
    );
  }
}
