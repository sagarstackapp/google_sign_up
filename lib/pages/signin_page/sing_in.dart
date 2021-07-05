import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_up/common/widget/color.dart';
import 'package:google_sign_up/common/widget/widget.dart';
import 'package:google_sign_up/model/user_model.dart';
import 'package:google_sign_up/pages/home_page/home.dart';
import 'package:google_sign_up/services/auth_service.dart';
import 'package:google_sign_up/services/user_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService authService = AuthService();
  UserService userService = UserService();
  String connection = 'Unknown';
  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void initState() {
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(checkConnection);
    super.initState();
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topMenuBar('In App Purchase'),
      body: connection == 'Unknown'
          ? showAPILoader(context)
          : google(signInWithGoogle),
    );
  }

  Future<void> signInWithGoogle() async {
    var authResult = await authService.signInWithGoogle(context);
    var productId = await userService.getProductId(authResult.user.uid);
    print('Get details : ${productId.uid}');
    String googleUserId = authResult.user.uid.toString();
    print('Current user id : $googleUserId');
    print('Current user details : ${authResult.additionalUserInfo.profile}');
    print('Purchased product id : ${productId.pid}');
    UserModel userDetails = UserModel(
      email: authResult.additionalUserInfo.profile['email'],
      lname: authResult.additionalUserInfo.profile['family_name'],
      fname: authResult.additionalUserInfo.profile['given_name'],
      image: authResult.additionalUserInfo.profile['picture'],
      uid: authResult.user.uid,
      pid: productId.pid,
    );

    // Response From Google
    // AdditionalUserInfo(isNewUser: false, profile: {given_name: Sagar, locale: en-GB, family_name: Stackapp, picture: https://lh3.googleusercontent.com/a-/AOh14GhbQy7Z7p1OZg1fh_Fuhn98k-_vQWpY7JFpRZET=s96-c, aud: 17508847403-e70i2j76t12vnglbdmgpj275s7tg6adm.apps.googleusercontent.com, azp: 17508847403-ts2adlcaj5upuis3fk15bepcr4msanlu.apps.googleusercontent.com, exp: 1620971700, iat: 1620968100, iss: https://accounts.google.com, sub: 111037160002170854379, name: Sagar Stackapp, email: sagaranghan.stackapp@gmail.com, email_verified: true}, providerId: google.com, username: null)
    await userService.createUser(userDetails);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  Future<void> checkConnection(ConnectivityResult connectivityResult) async {
    switch (connectivityResult) {
      case ConnectivityResult.mobile:
        print('Connection Type : $connectivityResult');
        Fluttertoast.showToast(
            msg: 'You are connected with Mobile network.!',
            textColor: ColorResources.White,
            backgroundColor: ColorResources.Orange);
        setState(() => connection = '$connectivityResult');
        break;
      case ConnectivityResult.wifi:
        print('Connection Type : $connectivityResult');
        Fluttertoast.showToast(
            msg: 'You are connected with WiFi network.!',
            textColor: ColorResources.White,
            backgroundColor: ColorResources.Orange);
        setState(() => connection = '$connectivityResult');
        break;
      case ConnectivityResult.none:
        print('Connection Type : $connectivityResult');
        Fluttertoast.showToast(
            msg: 'You are not connected with Any network.!',
            textColor: ColorResources.White,
            backgroundColor: ColorResources.Red);
        setState(() => connection = 'Unknown');
        break;
      default:
        print('Connection Type : $connectivityResult');
        setState(() => connection = 'Failed to get connectivity.');
        break;
    }
  }
}
