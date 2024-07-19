part of 'video_call_cubit.dart';


sealed class VideoCallState {}

final class VideoCallInitial extends VideoCallState {}

final class VideoCallInitialization extends VideoCallState {}

final class InVideoCall extends VideoCallState {}

final class VideoCallFailed extends VideoCallState {}


