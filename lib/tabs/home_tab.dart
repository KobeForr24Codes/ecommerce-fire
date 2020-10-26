import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fire/services/products.dart';
import 'package:ecommerce_fire/widgets/custom_action_bar.dart';
import 'package:ecommerce_fire/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productService.productsRef.get(),
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
                return GridView.count(
                  crossAxisCount: 1,
                  children: snapshot.data.docs.map((document) {
                    return ProductCard(
                      title: document.data()['name'],
                      imageUrl: document.data()['images'][0],
                      price: document.data()['price'].toString(),
                      productId: document.id,
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
            title: "FireCommerce",
            hasTitle: true,
            hasBackArrow: false,
          )
        ],
      ),
    );
  }
}
