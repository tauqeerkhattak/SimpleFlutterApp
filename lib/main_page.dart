import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_flutter_app/data_entry_page.dart';
import 'package:simple_flutter_app/simple_flutter_app.dart';
import 'package:simple_flutter_app/notifications.dart';
import 'package:simple_flutter_app/notifications_adding_page.dart';
import 'package:simple_flutter_app/profile.dart';
import 'package:simple_flutter_app/search_data_entry.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome!"),
        backgroundColor: Colors.blue,
      ),
      body: MainPageBody(),
    );
  }
}

class MainPageBody extends StatefulWidget {
  @override
  _MainPageBodyState createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: FlatButton(
                  child: Text("View Profile"),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Profile();
                      }
                    ));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: FlatButton(
                  child: Text("Add Notification"),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return NotificationAddingScreen();
                        }
                    ));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: FlatButton(
                  child: Text("View Notifications"),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return NotificationViewScreen();
                        }
                    ));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: FlatButton(
                  child: Text("Add Data Entry"),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return DataEntry();
                        }
                    ));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: FlatButton(
                  child: Text("Search Data Entry"),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SearchDataEntry();
                        }
                    ));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: FlatButton(
                  child: Text("Logout"),
                  color: Colors.blue,
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SimpleFlutterApp();
                        }
                      ));
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
