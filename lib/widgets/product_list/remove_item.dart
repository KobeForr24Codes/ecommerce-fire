import 'package:ecommerce_fire/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class RemoveItem extends StatelessWidget {
  final String userId;
  final String productId;

  const RemoveItem({Key key, this.productId, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            await UserService(uid: userId)
                .removeSavedProducts(productId)
                .then((value) => print(value));
          },
          child: Container(
            width: 42.0,
            height: 42.0,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FeatherIcons.x,
                  color: Colors.white,
                  size: 20.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
