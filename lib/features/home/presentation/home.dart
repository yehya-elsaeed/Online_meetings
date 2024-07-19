import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_meeting_app/core/utils/colors.dart';
import 'package:online_meeting_app/core/utils/fonts.dart';
import 'package:online_meeting_app/features/home/manager/audio_call_cubit/audio_call_cubit.dart';
import 'package:online_meeting_app/features/home/manager/join_setting_cubit/switch_button_cubit.dart';
import 'package:online_meeting_app/features/home/presentation/audio_screen.dart';
import 'package:online_meeting_app/features/home/presentation/create_meeting_code.dart';
import 'package:online_meeting_app/features/home/presentation/history.dart';
import 'package:online_meeting_app/features/home/presentation/join_code.dart';
import 'package:online_meeting_app/features/home/presentation/widgets/box_button.dart';
import 'package:online_meeting_app/features/login_screen/manager/login_cubit/login_cubit.dart';
import 'package:online_meeting_app/features/login_screen/presentation/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Meet & chat',
            style: style20,
          ),
          centerTitle: true,
          backgroundColor: backgroundColor,
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    GoogleSignIn().signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => LoginCubit(),
                              child: const LoginScreen(),
                            )));
                  },
                  icon: const Icon(
                    Icons.logout_sharp,
                    size: 30,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
        body: SafeArea(
            child: Column(
          children: [
            Container(
              color: Colors.transparent,
              child: Image.asset(
                'assets/images/met.png',
                width: 300,
                height: 250,
              ),
            ),
            Expanded(
              child: GridView(
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
                children: [
                  BoxButton(
                    iconData: Icons.videocam_sharp,
                    onAction: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return BlocProvider(
                            create: (context) => SwitchMuteButtonCubit(),
                            child: const CreateCodeMeetingScreen(),
                          );
                        }),
                      );
                    },
                    title: 'Create Metting',
                  ),
                  BoxButton(
                    iconData: Icons.video_call,
                    onAction: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => SwitchMuteButtonCubit(),
                                child: const JoinCodeScreen(),
                              )));
                    },
                    title: 'Join Meeting',
                  ),
                  BoxButton(
                    iconData: Icons.call,
                    onAction: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return BlocProvider(
                            create: (context) => AudioCallCubit(),
                            child: const AudioCallScreen(),
                          );
                        }),
                      );
                    },
                    title: 'Audio Call',
                  ),
                  BoxButton(
                    iconData: Icons.history_sharp,
                    onAction: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HistoryMeetings()));
                    },
                    title: 'History',
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
