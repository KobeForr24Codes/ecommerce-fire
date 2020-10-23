import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fire/constants.dart';
import 'package:ecommerce_fire/services/products.dart';
import 'package:ecommerce_fire/widgets/custom_input.dart';
import 'package:ecommerce_fire/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  ProductService _productService = ProductService();

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if (_searchString.isEmpty)
            Center(
              child: Container(
                child: Text(
                  "What's on your mind?",
                  style: Constants.regularDarkText,
                ),
              ),
            )
          else
            FutureBuilder<QuerySnapshot>(
              future: _productService.productsRef.orderBy("name").startAt(
                  [_searchString]).endAt(["$_searchString\uf8ff"]).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                      body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ));
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Container(
                        child: Text("No Products Found."),
                      ),
                    );
                  } else {
                    return ListView(
                      padding: EdgeInsets.only(
                        top: 108.0,
                        bottom: 12.0,
                      ),
                      children: snapshot.data.docs.map((document) {
                        return ProductCard(
                          title: document.data()['name'],
                          imageUrl: document.data()['images'][0],
                          price: "\$${document.data()['price']}",
                          productId: document.id,
                        );
                      }).toList(),
                    );
                  }
                }

                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: CustomInput(
              hintText: "Search here...",
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    _searchString = value;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
