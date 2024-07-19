import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:online_meeting_app/core/utils/fonts.dart';

class CallTimer extends StatefulWidget {
  const CallTimer({super.key});

  @override
  State<CallTimer> createState() => _CallTimerState();
}

class _CallTimerState extends State<CallTimer> {
  int _seconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        _seconds = _seconds + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Call Duration:',
            style: style20,
          ),
          Text(
            '${_seconds ~/ 60}:${(_seconds % 60).toString().padLeft(2, '0')}',
            style: style30.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
