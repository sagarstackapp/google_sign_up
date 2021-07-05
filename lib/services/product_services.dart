import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');

  //     ======================= Get Products data from products table =======================     //
  Future fetchProducts() async {
    try {
      return await productCollection.snapshots();
    } catch (e) {
      print('Catch error in Create User : $e');
    }
  }
}
