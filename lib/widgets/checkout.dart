import 'package:ecommerce_fire/constants.dart';
import 'package:ecommerce_fire/widgets/costum_button.dart';
import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;

  const Checkout({Key key, this.selectedTab, this.tabPressed})
      : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1.0,
                blurRadius: 10.0,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                "\$${(1000.00)}",
                style: Constants.boldHeading,
              ),
            ),
            Container(
              width: 200.0,
              child: CustomBtn(
                text: "Cashout",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
