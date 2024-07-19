import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreMethods {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  addNewUserDetails(User user) async {
    await _fireStore.collection('users').doc(user.uid).set({
      'userName': user.displayName,
      'uid': user.uid,
      'profilePhoto': user.photoURL,
    });
  }

  addMeeting(String channelId) async {
    try {
      await _fireStore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('mettings')
          .add({
        'channelId': channelId,
        'createdAt': DateTime.now().toString(),
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  getHistory(String channelId) async {
    try {
      await _fireStore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('mettings');
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
