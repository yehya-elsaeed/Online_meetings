import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_meeting_app/core/logic/bloc_observer.dart';
import 'package:online_meeting_app/core/logic/responsive_ref.dart';
import 'package:online_meeting_app/core/services/google_sign_in.dart';
import 'package:online_meeting_app/core/utils/colors.dart';
import 'package:online_meeting_app/features/home/presentation/home.dart';
import 'package:online_meeting_app/features/login_screen/presentation/login_screen.dart';
import 'package:online_meeting_app/features/login_screen/manager/login_cubit/login_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveRef().initResponsive(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Meeting',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: GoogleAuth().authChanges,
        builder: (context, snapShots) {
          if (snapShots.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapShots.hasData) {
            return const HomeScreen();
          }
          return BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginScreen(),
          );
        },
      ),
      //     BlocProvider(
      //   create: (context) => LoginCubit(),
      //   child: const LoginScreen(),
      // ),
    );
  }
}
