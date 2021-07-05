import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_up/model/user_model.dart';

class UserService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  //     ======================= Save User Data in Users Table =======================     //
  Future createUser(UserModel user) async {
    try {
      await userCollection.doc(user.uid).set(user.userMap());
    } catch (e) {
      print('Catch error in Create User : $e');
    }
  }

  //     ======================= Update User Data in Users Table =======================     //
  // ignore: missing_return
  Future purchaseId(String userId, productId) {
    try {
      userCollection.doc(userId).update(
        {'pid': FieldValue.arrayUnion(productId)},
      );
    } catch (e) {
      print('Catch error in Purchase Id : $e');
    }
  }

  //     ======================= Get current user data from firebase =======================     //
  Future<UserModel> getCurrentDataUser(String uid) async {
    try {
      DocumentSnapshot doc = await userCollection.doc(uid).get();
      return UserModel.fromMap(doc.data());
    } catch (e) {
      print('Catch error in Get Current User : $e');
      return null;
    }
  }

  //     ======================= Get current user ProductId from firebase =======================     //
  Future<UserModel> getProductId(String uid) async {
    try {
      DocumentSnapshot doc = await userCollection.doc(uid).get();
      return UserModel.fromMap(doc.data());
    } catch (e) {
      print('Catch error in Update product Id : $e');
      return null;
    }
  }
}
