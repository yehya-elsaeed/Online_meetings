import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_meeting_app/core/services/agora_audio_helper.dart';
import 'package:online_meeting_app/features/home/manager/audio_call_cubit/audio_call_cubit.dart';
import 'package:online_meeting_app/features/home/manager/audio_call_cubit/audio_call_state.dart';
import 'package:online_meeting_app/features/home/presentation/widgets/tool_bar_audio.dart';

class AudioCallScreen extends StatefulWidget {
  const AudioCallScreen({super.key});

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  late AgoraAudioHelper agoraAudioHelper;
  late AudioCallCubit cubit;
  @override
  void initState() {
    cubit = BlocProvider.of<AudioCallCubit>(context);
    agoraAudioHelper = AgoraAudioHelper(cubit, false);
    cubit.createAudioCall(agoraAudioHelper);
    super.initState();
  }

  @override
  void dispose() {
    agoraAudioHelper.engineDisposing();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<AudioCallCubit, AudioCallState>(
      builder: (context, state) {
        log('rebuild');
        return Stack(children: [
          Center(child: agoraAudioHelper.audioView()),
          Align(
              alignment: Alignment.bottomCenter,
              child: ToolBarAudio(agoraAudioHelper: agoraAudioHelper)),
        ]);
      },
    ));
  }
}
