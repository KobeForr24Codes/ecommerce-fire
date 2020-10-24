import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fire/constants.dart';
import 'package:ecommerce_fire/screens/cart_page.dart';
import 'package:ecommerce_fire/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CustomActionBar extends StatefulWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackground;
  final bool isCartPage;
  final bool hasCartBtn;

  CustomActionBar(
      {Key key,
      this.title,
      this.hasBackArrow,
      this.hasTitle,
      this.hasBackground,
      this.isCartPage,
      this.hasCartBtn})
      : super(key: key);

  @override
  _CustomActionBarState createState() => _CustomActionBarState();
}

class _CustomActionBarState extends State<CustomActionBar> {
  AuthService _authService = AuthService();

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = widget.hasBackArrow ?? false;
    bool _hasTitle = widget.hasTitle ?? false;
    bool _hasBackground = widget.hasBackground ?? true;
    bool _isCartPage = widget.isCartPage ?? false;
    bool _hasCartBtn = widget.hasCartBtn ?? true;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 1.0,
                blurRadius: 10.0,
              )
        ]
      ),
      padding: EdgeInsets.fromLTRB(24.0, 38.0, 24.0, 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Icon(
                  FeatherIcons.chevronLeft,
                  color: Colors.white,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              widget.title ?? "FireCommerce",
              style: Constants.boldHeading,
            ),
          if (_hasCartBtn)
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartPage()));
              },
              child: Container(
                width: 62.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: _isCartPage
                      ? Theme.of(context).accentColor
                      : Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FeatherIcons.shoppingCart,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    StreamBuilder(
                      stream: _usersRef
                          .doc(_authService.getUserId())
                          .collection("Cart")
                          .snapshots(),
                      builder: (context, snapshot) {
                        int _totalItems = 0;

                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          List _documents = snapshot.data.docs;
                          _totalItems = _documents.length;
                        }

                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            _totalItems.toString() ?? "0",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
