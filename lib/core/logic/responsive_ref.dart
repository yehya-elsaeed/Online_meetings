// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ResponsiveRef {
  late double width;
  late double height;
  ResponsiveRef.privateConst();
  static ResponsiveRef instance = ResponsiveRef.privateConst();
  factory ResponsiveRef() {
    return instance;
  }
  void initResponsive(BuildContext buildContext) {
    width = MediaQuery.of(buildContext).size.width;
    height = MediaQuery.of(buildContext).size.width;
  }

  double setWidthRatio(double ratio) => width * ratio;
  double setHeightRatio(double ratio) => height * ratio;
}
