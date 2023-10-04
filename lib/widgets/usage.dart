import 'package:flutter/material.dart';
import 'package:app_template/constants.dart';
import 'package:app_template/model.dart';

class UsageStatus extends StatelessWidget {
  final UsageState usage;

  final void Function() onHelpPressed;

  const UsageStatus(
      {super.key, required this.usage, required this.onHelpPressed});

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

  Flexible bar() {
    return Flexible(
        child: Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        height: 40,
        decoration: const BoxDecoration(
            color: AppColors.accentSecondary,
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    ));
  }

  Column usageLockup() {
    var barCount = 0;

    switch (usage) {
      case UsageState.min:
        barCount = 1;
        break;
      case UsageState.mid:
        barCount = 2;
        break;
      case UsageState.max:
        barCount = 3;
        break;
      default:
        break;
    }

    var emptyCount = UsageState.values.length - barCount - 1;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              for (var i = 0; i < barCount; i++) bar(),
              for (var i = 0; i < emptyCount; i++)
                const Expanded(child: SizedBox.shrink()),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (barCount == 1) ? "$barCount dose" : "$barCount doses",
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
