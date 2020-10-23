import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final CollectionReference productsRef = FirebaseFirestore.instance.collection("products");
}