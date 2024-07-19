import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class JoinMeetingMethods {
  final TextEditingController channelId = TextEditingController();
  final TextEditingController meetingName = TextEditingController();
  Uuid uuid = const Uuid();
  

  generateUuid() {
    final String v1 = uuid.v1();
    channelId.text = v1;
  }

  controllersDisposing() {
    channelId.dispose();
    meetingName.dispose();
  }

}
