import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fire/constants.dart';
import 'package:ecommerce_fire/screens/product_page.dart';
import 'package:ecommerce_fire/services/auth.dart';
import 'package:ecommerce_fire/services/products.dart';
import 'package:ecommerce_fire/services/user.dart';
import 'package:ecommerce_fire/widgets/custom_action_bar.dart';
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductPage(
                              productId: document.id,
                            ),
                          ),
                        );
                      },
                      child: FutureBuilder(
                        future:
                            _productService.productsRef.doc(document.id).get(),
                        builder: (context, productSnap) {
                          if (productSnap.hasError) {
                            return Container(
                              child: Center(
                                child: Text("${productSnap.error}"),
                              ),
                            );
                          }

                          if (productSnap.connectionState ==
                              ConnectionState.done) {
                            Map _productMap = productSnap.data.data();

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.network(
                                        _productMap['images'][0],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _productMap['name'],
                                            style: Constants.boldHeading,
                                          ),
                                          Text(
                                            "\$${_productMap['price']}",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: Theme.of(context).accentColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text("Size - ${document.data()['size']}", style: Constants.regularHeading,),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }

                          return Container(
                            margin: EdgeInsets.only(top: 50.0),
                            child: Center(
                              child: RefreshProgressIndicator(),
                            ),
                          );
                        },
                      ),
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
          )
        ],
      ),
    );
  }
}
