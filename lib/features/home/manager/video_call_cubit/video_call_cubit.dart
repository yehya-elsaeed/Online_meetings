import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_meeting_app/core/services/agora_video_helper.dart';

part 'video_call_state.dart';

class VideoCallCubit extends Cubit<VideoCallState> {
  VideoCallCubit() : super(VideoCallInitial());

  createVideoCall(AgoraVideoHelper agoraHelper) async {
    emit(VideoCallInitialization());
    try {
      await agoraHelper.initAgora();
      emit(InVideoCall());
    } catch (e) {
      emit(VideoCallFailed());
    }
  }

  void setChangesInVideoCall() => emit(InVideoCall());
}
