import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_up/common/method/methods.dart';
import 'package:google_sign_up/common/widget/color.dart';
import 'package:google_sign_up/common/widget/elevated_button.dart';
import 'package:google_sign_up/common/widget/widget.dart';
import 'package:google_sign_up/pages/home_page/home_view_model.dart';
import 'package:google_sign_up/pages/signin_page/sing_in.dart';
import 'package:google_sign_up/services/auth_service.dart';
import 'package:google_sign_up/services/product_services.dart';
import 'package:google_sign_up/services/user_service.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  AuthService authService = AuthService();
  UserService userService = UserService();
  ProductService productService = ProductService();
  Stream productsStream;
  HomeViewModel homeViewModel;

  @override
  void initState() {
    productService.fetchProducts().then((value) {
      setState(() {
        productsStream = value;
      });
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    // ignore: unnecessary_statements
    homeViewModel ?? (homeViewModel = HomeViewModel(this));

    return Scaffold(
      appBar: topMenuBar('In App Purchase'),
      body: productsStream == null && homeViewModel.userModel == null
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder(
              stream: productsStream,
              builder: (context, snapshot) {
                return snapshot.data == null
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Colors.blue,
                      ))
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          var data = snapshot.data.docs[index];
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                Image.network(data['image'], height: 200),
                                Container(
                                    color: ColorResources.black, height: 200),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 10),
                                    child: Text(
                                      '\$ ${data['price']}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: ColorResources.White,
                                      ),
                                    ),
                                  ),
                                ),
                                homeViewModel.userModel == null
                                    ? Container()
                                    : homeViewModel.userModel.pid.any(
                                            (element) =>
                                                data['pid'].contains(element))
                                        ? Positioned(
                                            bottom: 10,
                                            right: 10,
                                            child: CommonElevatedButton(
                                              text: 'Share',
                                              textColor: ColorResources.White,
                                              buttonColor:
                                                  ColorResources.Orange,
                                              onPressed: () async {
                                                Fluttertoast.showToast(
                                                    msg: 'Already Purchased');
                                                // print(isDataExist('1'));
                                              },
                                            ),
                                          )
                                        : Positioned(
                                            bottom: 10,
                                            right: 10,
                                            child: CommonElevatedButton(
                                              text: 'Buy now',
                                              textColor: ColorResources.White,
                                              buttonColor:
                                                  ColorResources.Orange,
                                              onPressed: () async {
                                                var userId =
                                                    homeViewModel.userModel.uid;
                                                var productId = data['pid'];
                                                Fluttertoast.showToast(
                                                  msg:
                                                      '${data['name']} purchases successfully',
                                                  backgroundColor:
                                                      ColorResources.Orange,
                                                  textColor:
                                                      ColorResources.White,
                                                );
                                                showLoader(context);
                                                await userService.purchaseId(
                                                    userId, productId);
                                                homeViewModel.userModel =
                                                    await userService
                                                        .getProductId(userId);
                                                hideLoader(context);
                                                setState(() {});
                                              },
                                            ),
                                          ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(height: 5);
                        },
                        itemCount: snapshot.data.docs.length,
                      );
              },
            ),
      floatingActionButton: floatingButton(signOut, 'signOut'),
    );
  }

  signOut() {
    authService.userSignOut();
    showLoader(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignIn()));
    setState(() {});
  }
}
