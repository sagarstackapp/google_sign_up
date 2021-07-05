import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_up/common/method/methods.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //     ======================= Google Sign In =======================     //
  Future signInWithGoogle(BuildContext context) async {
    try {
      showLoader(context);
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final credentials = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      var authResult = await firebaseAuth.signInWithCredential(credentials);
      return authResult;
    } catch (e) {
      print(e);
    }
  }

  //     ======================= SignOut =======================     //
  Future<void> userSignOut() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
  }

  //     ======================= Get Current User Details & Check User Logged In or Not =======================     //
  Future<bool> userLogInCheck() async {
    bool login;
    try {
      var user = firebaseAuth.currentUser;
      if (user == null) {
        print('No logged in user found');
        login = false;
        return login;
      } else {
        print(user);
        print('Hello, This is current user : ${user.displayName}');
        login = true;
        return login;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
