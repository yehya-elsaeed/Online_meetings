import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:online_meeting_app/core/services/agora_info.dart';

class RemoteVideoView extends StatelessWidget {
  const RemoteVideoView({super.key, required this.remoteUid, required this.engine});
  final int remoteUid;
  final  RtcEngine engine;

  @override
  Widget build(BuildContext context) {
    return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: engine,
          canvas: VideoCanvas(uid: remoteUid),
          connection: RtcConnection(channelId: AgoraInfo.channelName),
        ),
      );
  }
}