import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'switch_button_state.dart';

class SwitchMuteButtonCubit extends Cubit<SwitchMuteButtonState> {
  SwitchMuteButtonCubit() : super(SwithcMuteButtonInitial());
  bool isMutedMicrophone = false;
  bool isMutedCamera = false;
  void setCameraChanges(bool val) {
    isMutedCamera = val;
    log(val.toString());
    emit(SwithcMuteButtonChanged());
  }

  void setMicrophoneChanges(bool val) {
    isMutedMicrophone = val;
    log(val.toString());
    emit(SwithcMuteButtonChanged());
  }

  void get emitChanges => emit(SwithcMuteButtonChanged());
}
