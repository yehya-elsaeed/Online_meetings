import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_meeting_app/core/services/agora_audio_helper.dart';
import 'package:online_meeting_app/features/home/manager/audio_call_cubit/audio_call_state.dart';

class AudioCallCubit extends Cubit<AudioCallState> {
  AudioCallCubit() : super(AudioCallInitial());

  createAudioCall(AgoraAudioHelper agoraHelper) async {
    emit(AudioCallInitialization());
    try {
      await agoraHelper.initAgora();
      emit(InAudioCall());
    } catch (e) {
      emit(AudioCallFailed());
    }
  }

  void setChangesInAudioCall() => emit(InAudioCall());
}
