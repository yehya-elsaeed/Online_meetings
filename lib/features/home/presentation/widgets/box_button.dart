import 'package:flutter/material.dart';
import 'package:online_meeting_app/core/utils/colors.dart';
import 'package:online_meeting_app/core/utils/fonts.dart';

class BoxButton extends StatelessWidget {
  const BoxButton(
      {super.key,
      required this.iconData,
      required this.onAction,
      required this.title});
  final IconData iconData;
  final void Function() onAction;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onAction,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: amber,
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(colors: [
              amber,
              Color.fromARGB(255, 82, 73, 9),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: Colors.white,
              size: 90,
            ),
            const SizedBox(height: 10),
            Text(title, style: style15)
          ],
        ),
      ),
    );
  }
}
