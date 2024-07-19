import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_meeting_app/core/services/agora_video_helper.dart';
import 'package:online_meeting_app/features/home/manager/video_call_cubit/video_call_cubit.dart';
import 'package:online_meeting_app/features/home/presentation/widgets/tool_bar_video.dart';

class VideoSreen extends StatefulWidget {
  const VideoSreen(
      {super.key,
      required this.channelId,
      required this.isHost,
      required this.isMuteCamera,
      required this.isMuteMicrophone});
  final String channelId;
  final bool isHost;
  final bool isMuteCamera;
  final bool isMuteMicrophone;
  @override
  State<VideoSreen> createState() => _VideoSreenState();
}

class _VideoSreenState extends State<VideoSreen> {
  late AgoraVideoHelper agoraHelper;
  late VideoCallCubit cubit;
  @override
  void initState() {
    cubit = BlocProvider.of<VideoCallCubit>(context);
    agoraHelper = AgoraVideoHelper(
        cubit, widget.isMuteMicrophone, widget.isMuteCamera, widget.channelId);
    cubit.createVideoCall(agoraHelper);
    super.initState();
  }

  @override
  void dispose() {
    agoraHelper.engineDisposing();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<VideoCallCubit, VideoCallState>(
        builder: (context, state) {
          log('Rebuilding');
          return SafeArea(
            child: Stack(
              children: [
                Center(
                  child: agoraHelper.remoteVideoView(),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 100,
                    height: 150,
                    child: Center(
                      child: agoraHelper.localVideoView(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                      child: widget.isHost == true
                          ? IconButton(
                              splashRadius: 2,
                              style: IconButton.styleFrom(
                                  shape: const CircleBorder()),
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: widget.channelId));
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Copied to clipboard')));
                              },
                              icon: const Icon(Icons.copy))
                          : Container()),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: ToolBarVideo(
                      agoraVideoHelper: agoraHelper,
                    )),
                    
              ],
            ),
          );
        },
      ),
    );
  }
}
