import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_meeting_app/core/utils/colors.dart';
import 'package:online_meeting_app/core/utils/fonts.dart';

class HistoryMeetings extends StatefulWidget {
  const HistoryMeetings({super.key});

  @override
  State<HistoryMeetings> createState() => _HistoryMeetingsState();
}

class _HistoryMeetingsState extends State<HistoryMeetings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meeting History',
          style: style20,
        ),
         iconTheme: const IconThemeData(
          color: Colors.white, // Change your color here
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('mettings')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No meetings found'));
          }
          final meetings = snapshot.data!.docs;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: meetings.length,
            itemBuilder: (context, index) {
              final meeting = meetings[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.white24,
                  color: footerColor,
                  child: ListTile(
                    title: Text(
                      meeting['channelId'],
                      style: style15,
                    ),
                    subtitle: Text(
                      'Date: ${meeting['createdAt']}',
                      style: style15.copyWith(color: Colors.white60),
                    ),
                    onTap: () {},
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
