import 'package:flutter/material.dart';
import 'package:online_meeting_app/core/logic/responsive_ref.dart';
import 'package:online_meeting_app/core/services/agora_audio_helper.dart';
import 'package:online_meeting_app/core/utils/colors.dart';

class ToolBarAudio extends StatelessWidget {
  const ToolBarAudio({super.key, required this.agoraAudioHelper});
  final AgoraAudioHelper agoraAudioHelper;
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
                agoraAudioHelper.muteMicrophone();
              },
              icon: Icon(
                agoraAudioHelper.isMuteMicrophone
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
              },
              icon: Icon(
                Icons.more_vert_outlined,
                size: ResponsiveRef().setWidthRatio(.1),
                color: Colors.white60,
              ))
        ],
      ),
    );
  }
}
