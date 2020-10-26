import 'package:ecommerce_fire/widgets/costum_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  Center(child: Text('Logging Out')),
                ],
              ),
            ),
          );
        },
      );
    }

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 42.0,
        ),
        child: ListView(
          shrinkWrap: true,
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Flexible(
              child: CustomBtn(
                text: "Logout",
                onPressed: () async {
                  _showMyDialog();
                  await FirebaseAuth.instance.signOut()
                    .then((value) {
                      Navigator.pop(context);
                    });

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
