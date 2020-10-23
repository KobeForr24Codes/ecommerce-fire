import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final uid;

  UserService({this.uid});

  FirebaseFirestore userService = FirebaseFirestore.instance;
  final CollectionReference usersRef = FirebaseFirestore.instance.collection("Users");

  Future addToCart(String productId, String selectedProductSize) {
    return usersRef
        .doc(uid)
        .collection("Cart")
        .doc(productId)
        .set({"size": selectedProductSize});
  }

  // bookmark products
  Future saveProduct(String productId) {
    return usersRef
        .doc(uid)
        .collection("Saved")
        .doc(productId)
        .set({"createdAt": FieldValue.serverTimestamp()});
  }

  Future<String> removeSavedProducts(String productId) {
    String message = "";

    return usersRef
      .doc(uid)
      .collection("Saved")
      .doc(productId)
      .delete()
      .then((value) {
        message = "Product removed.";
        return message;
      })
      .catchError((error) {
        message = "Failed to remove product.";
        return message;
      });
  }
}
