import 'package:ecommerce_fire/screens/home_page.dart';
import 'package:ecommerce_fire/screens/login_page.dart';
import 'package:ecommerce_fire/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // return either Home or Authenticate Widget
    if (user == null) {
      return LoginPage();
    } else {
      return HomePage();
    }
  }
}
