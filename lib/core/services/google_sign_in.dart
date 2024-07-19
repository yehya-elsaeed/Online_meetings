import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_meeting_app/core/services/firestore_methods.dart';

class GoogleAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  Stream<User?> get authChanges => _auth.authStateChanges();

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    User? user = userCredential.user;
    if (user == null) throw Exception('Some thing went wrong');

    checkNewUser(userCredential, user);
  }

  checkNewUser(UserCredential userCredential, User user) {
    if (userCredential.additionalUserInfo!.isNewUser) {
      _firestoreMethods.addNewUserDetails(user);
    }
  }
}
