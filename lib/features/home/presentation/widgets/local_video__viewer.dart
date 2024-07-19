import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class LocalVideoViewer extends StatelessWidget {
  const LocalVideoViewer({super.key, required this.engine});
  final RtcEngine engine;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 150,
      child: AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: engine,
          canvas: const VideoCanvas(uid: 0),
        ),
      ),
    );
  }
}
