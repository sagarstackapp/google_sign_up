import 'package:flutter/material.dart';
import 'package:google_sign_up/common/widget/color.dart';
import 'package:sign_button/sign_button.dart';

Widget topMenuBar(String title) {
  return PreferredSize(
    preferredSize: Size(double.infinity, 80),
    child: AppBar(
      backgroundColor: ColorResources.Red,
      title: Text(title),
      centerTitle: true,
      elevation: 10,
      automaticallyImplyLeading: false,
      shadowColor: Color(0xFFFFE35452),
    ),
  );
}

Widget google(VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: SignInButton(
      buttonType: ButtonType.google,
      width: double.infinity,
      buttonSize: ButtonSize.large,
      onPressed: onPressed,
    ),
  );
}

Widget showAPILoader(BuildContext context) {
  return Center(
    child: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
}

Widget floatingButton(VoidCallback onPressed, String heroTag) {
  return FloatingActionButton(
    heroTag: heroTag,
    onPressed: onPressed,
    child: Icon(Icons.logout),
    backgroundColor: ColorResources.red,
    elevation: 20,
  );
}


