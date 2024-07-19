

sealed class AudioCallState {}

final class AudioCallInitial extends AudioCallState {}

final class AudioCallInitialization extends AudioCallState {}

final class InAudioCall extends AudioCallState {}

final class AudioCallFailed extends AudioCallState {}
