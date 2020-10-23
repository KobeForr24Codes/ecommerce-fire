import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fire/services/products.dart';
import 'package:ecommerce_fire/services/user.dart';
import 'package:ecommerce_fire/widgets/custom_action_bar.dart';
import 'package:ecommerce_fire/widgets/product_list/index.dart';
import 'package:flutter/material.dart';

class SavedTab extends StatefulWidget {
  final String userId;

  const SavedTab({Key key, this.userId}) : super(key: key);

  @override
  _SavedTabState createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: UserService()
                  .usersRef
                  .doc(widget.userId)
                  .collection("Saved")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error ${snapshot.error}"),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.active) {
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 100.0,
                      bottom: 24.0,
                    ),
                    children: snapshot.data.docs.map((document) {
                      return ProductList(
                        document: document,
                        productService: _productService,
                      );
                    }).toList(),
                  );
                }

                return Container(
                  margin: EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: RefreshProgressIndicator(),
                  ),
                );
              }),
          CustomActionBar(
            title: "Saved Products",
            hasCartBtn: false,
            hasTitle: true,
            hasBackArrow: false,
          )
        ],
      ),
    );
  }
}
