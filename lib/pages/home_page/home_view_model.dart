import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_up/model/user_model.dart';
import 'package:google_sign_up/pages/home_page/home.dart';
import 'package:google_sign_up/services/user_service.dart';

class HomeViewModel {
  var uid = FirebaseAuth.instance.currentUser.uid;

  HomeState homeState;
  UserModel userModel;
  UserService userService = UserService();

  HomeViewModel(this.homeState) {
    getUserDetails(uid);
  }

  Future getUserDetails(String uid) async {
    var value = await userService.getCurrentDataUser(uid);
    if (value == null) {
      print('View Model data is null');
    } else {
      userModel = value;
      print('From Home model : ${userModel.userMap()}');
    }

    // ignore: invalid_use_of_protected_member
    homeState.setState(() {});
  }
}
