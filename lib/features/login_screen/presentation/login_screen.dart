import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:online_meeting_app/core/logic/responsive_ref.dart';
import 'package:online_meeting_app/core/utils/fonts.dart';
import 'package:online_meeting_app/core/utils/snack_bar.dart';
import 'package:online_meeting_app/features/home/presentation/home.dart';
import 'package:online_meeting_app/features/login_screen/manager/login_cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
        body: Center(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 115.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Start or join a meeting', style: style25),
              const Expanded(child: SizedBox(height: 0)),
              Image.asset(
                'assets/images/aauibhlps.png',
                width: ResponsiveRef().setWidthRatio(0.76),
                height: ResponsiveRef().setHeightRatio(.76),
              ),
              const Expanded(child: SizedBox(height: 0)),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginLoading) {
                    cubit.title = const SizedBox(
                      width: 35,
                      height: 20,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballPulse,
                        colors: [Colors.white],
                      ),
                    );
                  } else if (state is LoginFailed) {
                    cubit.title = const Text('Google sign in', style: style20);
                    showSnackBar(context, state.errMsg);
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const HomeScreen()));
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () async {
                      await cubit.googleLogin(context);
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(ResponsiveRef().setWidthRatio(.9),
                            ResponsiveRef().setHeightRatio(.15)),
                        backgroundColor:
                            const Color.fromARGB(255, 231, 173, 0)),
                    child: cubit.title,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
