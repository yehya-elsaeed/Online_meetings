
import 'package:agora_rtc_engine/agora_rtc_engine.dart';


abstract class Iagora {
  bool get getLocalUserJoined;
  int? get getRemoteUserId;
  RtcEngine get getEngine;
  bool get getIsMuteCamera;
  bool get getIsMuteMicrophone;

  void engineDisposing();

  Future<void> initAgora();
}
