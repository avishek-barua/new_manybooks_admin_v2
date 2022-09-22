import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'after_login.dart';

class FirebaseAuthMethod {
  // final FirebaseAuth _auth;

  // FirebaseAuthMethod(this._auth);

  // User get user => _auth.currentUser!;

  // Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   // Optional clientId
  //   clientId:
  //       '19204081567-kl99td6h0nbo61tkbstba07ef2dp4vsn.apps.googleusercontent.com',
  //   scopes: <String>[
  //     'email',
  //   ],
  // );

  // Future<void> signInWithGoogle(BuildContext context) async {
  //   try {
  //     if (kIsWeb) {
  //       GoogleAuthProvider googleProvider = GoogleAuthProvider();
  //       googleProvider
  //           .addScope('https://www.googleapis.com/auth/contacts.readonly');
  //       await _auth.signInWithPopup(googleProvider);
  //     } else {
  //       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //       final GoogleSignInAuthentication? googleAuth =
  //           await googleUser?.authentication;
  //       if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
  //         final credential = GoogleAuthProvider.credential(
  //           accessToken: googleAuth?.accessToken,
  //           idToken: googleAuth?.idToken,
  //         );
  //         UserCredential userCredential =
  //             await _auth.signInWithCredential(credential);
  //         if (userCredential != null) {
  //           if (userCredential.additionalUserInfo!.isNewUser) {}
  //         }
  //       }
  //     }
  //   } on FirebaseException catch (e) {}
  // }

  Future<AfterLogin> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = userCredential.user;

    return AfterLogin(
        credential.accessToken, user?.email, user?.displayName, "google");
  }
}
