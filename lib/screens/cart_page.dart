import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fire/services/auth.dart';
import 'package:ecommerce_fire/services/products.dart';
import 'package:ecommerce_fire/services/user.dart';
import 'package:ecommerce_fire/widgets/checkout.dart';
import 'package:ecommerce_fire/widgets/custom_action_bar.dart';
import 'package:ecommerce_fire/widgets/product_list/index.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  UserService userService = UserService();
  AuthService _authService = AuthService();
  ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: userService.usersRef
                .doc(_authService.getUserId())
                .collection("Cart")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error ${snapshot.error}"),
                  ),
                );
              }

              // Collection Data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                // Display the data inside a list view

                return ListView(
                  padding: EdgeInsets.only(
                    top: 100.0,
                    bottom: 24.0,
                  ),
                  children: snapshot.data.docs.map((document) {
                    return ProductList(
                      document: document,
                      productService: _productService,
                      isCartView: true,
                    );
                  }).toList(),
                );
              }

              // Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            hasBackArrow: true,
            title: "Cart",
            isCartPage: true,
          ),
          Checkout(
            selectedTab: 1,
          )
        ],
      ),
    );
  }
}
