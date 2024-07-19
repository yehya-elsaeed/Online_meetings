import 'package:flutter/material.dart';
import 'package:online_meeting_app/core/utils/colors.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({super.key, required this.value, required this.onChanged});
  final void Function(bool val) onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: value,
        activeColor: Colors.green,
        inactiveTrackColor: secondaryBackgroundColor,
        thumbColor: const MaterialStatePropertyAll<Color>(Colors.white),
        onChanged: (val) {
          onChanged(val);
        });
  }
}
