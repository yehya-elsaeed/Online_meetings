import 'package:flutter/material.dart';
import 'package:online_meeting_app/features/home/presentation/widgets/call_time.dart';
import 'package:online_meeting_app/features/home/presentation/widgets/in_ringing.dart';

class AudioContent extends StatelessWidget {
  const AudioContent({super.key, this.remoteUid});
  final int? remoteUid;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 145),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.black,
            backgroundImage: AssetImage('assets/images/anoy.jpg'),
            radius: 50,
          ),
          const SizedBox(height: 18),
          if (remoteUid != null)
            const CallTimer()
          else
            const InRinging(
                title1: 'Waiting for response', title2: 'Ringing..'),
        ],
      ),
    );
  }
}
