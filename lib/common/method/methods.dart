import 'package:flutter/material.dart';
import 'package:google_sign_up/pages/home_page/home.dart';
import 'package:google_sign_up/pages/signin_page/sing_in.dart';

showLoader(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: Colors.transparent,
            ),
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.orange),
                strokeWidth: 5,
                backgroundColor: Colors.white,
              ),
            )
          ],
        ),
      );
    },
  );
}

hideLoader(BuildContext context) {
  Navigator.of(context, rootNavigator: false).pop();
}

Future<void> showMyDialog(context, text) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Purchase Confirmation'),
        content: Text(text),
        actions: [
          TextButton(
            child: Text('Confirm'),
            onPressed: () {
              print('Confirmed');
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

goHome(BuildContext context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => Home()));
}

goSignIn(BuildContext context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => SignIn()));
}
