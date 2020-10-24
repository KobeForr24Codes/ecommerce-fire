import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fire/models/user.dart';
import 'package:ecommerce_fire/screens/product_page.dart';
import 'package:ecommerce_fire/services/products.dart';
import 'package:ecommerce_fire/widgets/product_list/product_overview.dart';
import 'package:ecommerce_fire/widgets/product_list/remove_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  final QueryDocumentSnapshot document;
  final ProductService productService;
  final bool isCartView;

  const ProductList(
      {Key key, this.document, this.productService, this.isCartView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isCartView = isCartView ?? false;
    final user = Provider.of<User>(context);

    return StreamBuilder(
      stream: productService.productsRef.doc(document.id).snapshots(),
      builder: (context, productSnap) {
        if (productSnap.hasError) {
          return Container(
            child: Center(
              child: Text("${productSnap.error}"),
            ),
          );
        }

        if (productSnap.connectionState == ConnectionState.active) {
          Map _productMap = productSnap.data.data();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
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
                          child: ProductOverview(
                              product: _productMap,
                              isCartView: _isCartView,
                              productSize: document.data()['size']),
                        ),
                      ),
                      RemoveItem(
                        userId: user.uid,
                        productId: document.id,
                      ),
                    ],
                  ),
                ),
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
    );
  }
}
