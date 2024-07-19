import 'package:flutter/material.dart';
import 'package:online_meeting_app/core/logic/responsive_ref.dart';
import 'package:online_meeting_app/core/services/agora_video_helper.dart';
import 'package:online_meeting_app/core/utils/colors.dart';

class ToolBarVideo extends StatelessWidget {
  const ToolBarVideo({super.key, required this.agoraVideoHelper});
  final AgoraVideoHelper agoraVideoHelper;
  @override
  Widget build(BuildContext context) {
    // final cubit
    return Container(
      height: ResponsiveRef().setHeightRatio(.22),
      width: double.infinity,
      decoration: const BoxDecoration(color: footerColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                agoraVideoHelper.muteMicrophone();
              },
              icon: Icon(
                agoraVideoHelper.isMuteMicrophone
                    ? Icons.mic
                    : Icons.mic_off_rounded,
                size: ResponsiveRef().setWidthRatio(.1),
                color: Colors.white60,
              )),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Container(
              padding: const EdgeInsets.all(9),
              decoration: const BoxDecoration(
                  color: Colors.red, shape: BoxShape.circle),
              child: const Icon(
                Icons.call_end,
                color: Colors.white,
              ),
            ),
            iconSize: ResponsiveRef().setWidthRatio(.1),
          ),
          IconButton(
              onPressed: () {
                agoraVideoHelper.muteCamera();
              },
              icon: Icon(
                agoraVideoHelper.isMuteCamera
                    ? Icons.videocam_rounded
                    : Icons.videocam_off_outlined,
                size: ResponsiveRef().setWidthRatio(.1),
                color: Colors.white60,
              ))
        ],
      ),
    );
  }
}
