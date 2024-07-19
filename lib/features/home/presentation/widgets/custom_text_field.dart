import 'package:flutter/material.dart';
import 'package:online_meeting_app/core/logic/join_meeting_methods.dart';
import 'package:online_meeting_app/core/logic/validation.dart';
import 'package:online_meeting_app/core/utils/colors.dart';
import 'package:online_meeting_app/core/utils/fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      this.iconButton,
      this.textFieldMethods,
      this.hint});
  final TextEditingController controller;
  final bool? iconButton;
  final JoinMeetingMethods? textFieldMethods;
  final String? hint;
  @override
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: ValidationText().codeValidation,
      controller: controller,
      textAlign: TextAlign.center,
      cursorColor: Colors.white54,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
          hintText: hint ?? '',
          hintStyle: style15.copyWith(
              color: Colors.white60, fontWeight: FontWeight.w300),
          suffixIcon: iconButton != null
              ? IconButton(
                  onPressed: () {
                    textFieldMethods!.generateUuid();
                  },
                  icon: const Icon(
                    Icons.replay,
                    color: Colors.white60,
                  ))
              : null,
          border: InputBorder.none,
          fillColor: secondaryBackgroundColor,
          filled: true),
    );
  }
}
