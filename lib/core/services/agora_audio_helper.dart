import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:online_meeting_app/core/services/Iagora.dart';
import 'package:online_meeting_app/core/services/agora_info.dart';
import 'package:online_meeting_app/features/home/manager/audio_call_cubit/audio_call_cubit.dart';
import 'package:online_meeting_app/features/home/presentation/widgets/audio_content.dart';
import 'package:online_meeting_app/features/home/presentation/widgets/in_ringing.dart';
import 'package:permission_handler/permission_handler.dart';

class AgoraAudioHelper implements Iagora {
  final AudioCallCubit cubit;
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool isMuteMicrophone;
  AgoraAudioHelper(this.cubit , this.isMuteMicrophone);

  @override
  void engineDisposing() {
    _engine.leaveChannel();
    _engine.release();
    log('Disposed');
  }

  @override
  Future<void> initAgora() async {
    try {
      await [Permission.microphone].request();
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
            cubit.setChangesInAudioCall();
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            _remoteUid = remoteUid;
            cubit.setChangesInAudioCall();
          },
          onUserOffline: (RtcConnection connection, int remoteUid,
              UserOfflineReasonType reason) {
            _remoteUid = null;
            cubit.setChangesInAudioCall();
          },
          onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
            log('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
          },
        ),
      );

      await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

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
    cubit.setChangesInAudioCall();
  }

  @override
  RtcEngine get getEngine => _engine;

  @override
  bool get getLocalUserJoined => _localUserJoined;

  @override
  int? get getRemoteUserId => _remoteUid;

  Widget audioView() {
    if (_localUserJoined == true) {
      return AudioContent(remoteUid: _remoteUid);
    } else {
      return const InRinging(title1: 'Connecting', title2: 'Connecting');
    }
  }

  @override
  bool get getIsMuteCamera => true;

  @override
  bool get getIsMuteMicrophone => isMuteMicrophone;

}
