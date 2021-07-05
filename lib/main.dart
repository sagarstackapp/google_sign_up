import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_up/pages/home_page/home.dart';
import 'package:google_sign_up/pages/signin_page/sing_in.dart';
import 'package:google_sign_up/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userLogin = false;
  AuthService authService = AuthService();

  @override
  void initState() {
    logInCheck();
    super.initState();
  }

  logInCheck() async {
    bool user = await authService.userLogInCheck();
    setState(() {});
    userLogin = user;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userLogin ? Home() : SignIn(),
    );
  }
}
