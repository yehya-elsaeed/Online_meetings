import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:online_meeting_app/core/services/google_sign_in.dart';
import 'package:online_meeting_app/core/utils/fonts.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Widget title = const Text('Google sign in', style: style20);
  final GoogleAuth _googleAuth = GoogleAuth();
  googleLogin(BuildContext context) async {
    emit(LoginLoading());
    try {
      await _googleAuth.signInWithGoogle(context);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }
}
