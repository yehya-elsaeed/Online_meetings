import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_meeting_app/core/logic/join_meeting_methods.dart';
import 'package:online_meeting_app/core/logic/responsive_ref.dart';
import 'package:online_meeting_app/core/utils/colors.dart';
import 'package:online_meeting_app/core/utils/fonts.dart';
import 'package:online_meeting_app/features/home/manager/join_setting_cubit/switch_button_cubit.dart';
import 'package:online_meeting_app/features/home/manager/video_call_cubit/video_call_cubit.dart';
import 'package:online_meeting_app/features/home/presentation/video_screen.dart';
import 'package:online_meeting_app/features/home/presentation/widgets/custom_text_field.dart';
import 'package:online_meeting_app/features/home/presentation/widgets/switch_button.dart';

class CreateCodeMeetingScreen extends StatefulWidget {
  const CreateCodeMeetingScreen({super.key});

  @override
  State<CreateCodeMeetingScreen> createState() =>
      _CreateCodeMeetingScreenState();
}

class _CreateCodeMeetingScreenState extends State<CreateCodeMeetingScreen> {
  JoinMeetingMethods joinMeetingMethods = JoinMeetingMethods();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    joinMeetingMethods.generateUuid();
    super.initState();
  }

  @override
  void dispose() {
    joinMeetingMethods.controllersDisposing();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SwitchMuteButtonCubit>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create a meeting',
            style: style20,
          ),
          iconTheme: const IconThemeData(
            color: Colors.white, // Change your color here
          ),
          centerTitle: true,
          backgroundColor: backgroundColor,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  CustomTextField(
                    controller: joinMeetingMethods.channelId,
                    iconButton: true,
                    textFieldMethods: joinMeetingMethods,
                    hint: 'Meeting Code',
                  ),
                  SizedBox(height: ResponsiveRef().setHeightRatio(.05)),
                  CustomTextField(
                    controller: joinMeetingMethods.meetingName,
                    hint: 'Meeting Name',
                  ),
                  SizedBox(height: ResponsiveRef().setHeightRatio(.07)),
                  InkWell(
                    onTap: () {
                      if (_key.currentState!.validate()) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => VideoCallCubit(),
                                  child: VideoSreen(
                                    channelId:
                                        joinMeetingMethods.channelId.text,
                                    isHost: true,
                                    isMuteCamera: cubit.isMutedCamera,
                                    isMuteMicrophone: cubit.isMutedMicrophone,
                                  ),
                                )));
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: ResponsiveRef().setHeightRatio(.09),
                      width: ResponsiveRef().setWidthRatio(.21),
                      decoration:
                          const BoxDecoration(color: secondaryBackgroundColor),
                      child: const Text(
                        'Create',
                        style: style15,
                      ),
                    ),
                  ),
                  BlocBuilder<SwitchMuteButtonCubit, SwitchMuteButtonState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              color: secondaryBackgroundColor,
                              child: Row(
                                children: [
                                  const Text(
                                    'Mute Microphone',
                                    style: style15,
                                  ),
                                  const Spacer(),
                                  SwitchButton(
                                      value: cubit.isMutedMicrophone,
                                      onChanged: cubit.setMicrophoneChanges),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              color: secondaryBackgroundColor,
                              child: Row(
                                children: [
                                  const Text(
                                    'Mute Camera',
                                    style: style15,
                                  ),
                                  const Spacer(),
                                  SwitchButton(
                                      value: cubit.isMutedCamera,
                                      onChanged: cubit.setCameraChanges),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
