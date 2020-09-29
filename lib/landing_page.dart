import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_flutter_app/simple_flutter_app.dart';
import 'main_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot) {
        if(snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if(user == null) {
            return SimpleFlutterApp();
          }
          return MainPage();
        }
        else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

}