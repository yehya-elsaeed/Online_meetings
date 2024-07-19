import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:online_meeting_app/core/services/Iagora.dart';
import 'package:online_meeting_app/core/services/agora_info.dart';
import 'package:online_meeting_app/core/services/firestore_methods.dart';
import 'package:online_meeting_app/features/home/manager/video_call_cubit/video_call_cubit.dart';
import 'package:online_meeting_app/features/home/presentation/widgets/in_ringing.dart';
import 'package:online_meeting_app/features/home/presentation/widgets/local_video__viewer.dart';
import 'package:online_meeting_app/features/home/presentation/widgets/remote_video_viewer.dart';
import 'package:permission_handler/permission_handler.dart';

class AgoraVideoHelper implements Iagora {
  final FirestoreMethods firestoreMethods = FirestoreMethods();
  final VideoCallCubit cubit;
  late RtcEngine _engine;
  final String channelId;
  int? _remoteUid;
  bool _localUserJoined = false;
  bool isMuteMicrophone;
  bool isMuteCamera;

  AgoraVideoHelper(
      this.cubit, this.isMuteMicrophone, this.isMuteCamera, this.channelId);

  @override
  void engineDisposing() {
    _engine.leaveChannel();
    _engine.release();
    log('Disposed');
  }

  @override
  Future<void> initAgora() async {
    try {
      await [Permission.camera, Permission.microphone].request();
      _engine = createAgoraRtcEngine();
      await _engine.initialize(RtcEngineContext(
        appId: AgoraInfo.appId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ));
      _engine.registerEventHandler(
        RtcEngineEventHandler(
          onError: (type, msg) {
            log(type.toString());
          },
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            _localUserJoined = true;
            cubit.setChangesInVideoCall();
            firestoreMethods.addMeeting(channelId);
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            _remoteUid = remoteUid;
            cubit.setChangesInVideoCall();
          },
          onUserOffline: (RtcConnection connection, int remoteUid,
              UserOfflineReasonType reason) {
            _remoteUid = null;
            cubit.setChangesInVideoCall();
          },
          onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
            log('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
          },
        ),
      );

      await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      isMuteMicrophone
          ? await _engine.enableAudio()
          : await _engine.disableAudio();
      isMuteCamera ? await _engine.disableVideo() : await _engine.enableVideo();
      await _engine.startPreview();
      await _engine.joinChannel(
        token: AgoraInfo.token,
        channelId: AgoraInfo.channelName,
        uid: 0,
        options: const ChannelMediaOptions(),
      );
      log('Initiated');
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  muteMicrophone() async {
    isMuteMicrophone = !isMuteMicrophone;
    if (isMuteMicrophone) {
      await _engine.disableAudio();
    } else {
      await _engine.enableAudio();
    }
    cubit.setChangesInVideoCall();
  }

  muteCamera() async {
    isMuteCamera = !isMuteCamera;
    if (isMuteCamera) {
      await _engine.disableVideo();
    } else {
      await _engine.enableVideo();
    }
    cubit.setChangesInVideoCall();
  }

  @override
  RtcEngine get getEngine => _engine;

  @override
  bool get getLocalUserJoined => _localUserJoined;

  @override
  int? get getRemoteUserId => _remoteUid;

  @override
  bool get getIsMuteCamera => isMuteCamera;

  @override
  bool get getIsMuteMicrophone => isMuteMicrophone;

  Widget remoteVideoView() {
    if (_remoteUid != null) {
      return RemoteVideoView(engine: _engine, remoteUid: _remoteUid!);
    } else {
      return const InRinging(
          title1: 'Waiting Users',
          title2: 'Video Will Shared Once User Joined');
    }
  }

  Widget localVideoView() {
    if (_localUserJoined == true) {
      return LocalVideoViewer(engine: _engine);
    } else {
      return const CircularProgressIndicator();
    }
  }
}
