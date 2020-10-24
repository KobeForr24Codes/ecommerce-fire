import 'package:ecommerce_fire/constants.dart';
import 'package:flutter/material.dart';

class ProductOverview extends StatelessWidget {
  final Map<dynamic, dynamic> product;
  final bool isCartView;
  final String productSize;

  const ProductOverview({Key key, this.product, this.isCartView, this.productSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isCartView = isCartView ?? false;

    return Row(
      children: [
        Container(
          width: 90,
          height: 90,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              product['images'][0],
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Constants.boldHeading.copyWith(fontSize: 16.0),
                ),
                _isCartView
                    ? Row(
                        children: [
                          Text(
                            "\$${product['price']}",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Size - $productSize" ?? " ",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        "\$${product['price']}",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
