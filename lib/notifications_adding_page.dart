import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:simple_flutter_app/notifications.dart';
//
//void main () {
//  WidgetsFlutterBinding.ensureInitialized();
//  Firebase.initializeApp();
//  runApp(NotificationAddingScreen());
//}

class NotificationAddingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Adding Page"),
        backgroundColor: Colors.blue,
      ),
      body: NotificationAddingBody(),
    );
  }
}

class NotificationAddingBody extends StatefulWidget {
  @override
  _NotificationAddingBodyState createState() => _NotificationAddingBodyState();
}

class _NotificationAddingBodyState extends State<NotificationAddingBody> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _addNotificationToFirebase (String title,String desc) {
    FirebaseFirestore.instance.collection("Notifications").doc(formatDate(DateTime.now(),[mm,' ',dd,',',yyyy,'   ',hh,':',nn,':',ss])).set({
      "Title":title,
      "Description":desc,
      "Date":formatDate(DateTime.now(),[mm,' ',dd,',',yyyy,'   ',hh,':',nn,':',ss]),
    }).then((value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Operation Successful!"),
            content: Text("Notification successfully added!"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  titleController.text = "";
                  descController.text = "";
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
      );
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: TextFormField(
                  controller: titleController,
                  validator: (String title) {
                    if(title.isEmpty || title == null) {
                      return "Please enter a title";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Title:",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: TextFormField(
                  controller: descController,
                  validator: (String desc) {
                    if(desc.isEmpty || desc == null) {
                      return "Please enter description";
                    }
                    else if (desc.length < 20) {
                      return "Description must be at least 20 characters.";
                    }
                    return null;
                  },
                  minLines: 5,
                  maxLines: 6,
                  decoration: InputDecoration(
                    labelText: "Description:",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: FlatButton(
                  child: Text("Submit"),
                  color: Colors.blue,
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirmation"),
                            content: Text("Are you sure you want to add this notification?"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Sure"),
                                onPressed: () {
                                  String title = titleController.text;
                                  String description = descController.text;
                                  _addNotificationToFirebase(title,description);
                                  Navigator.pop(context);
                                },
                              ),
                              FlatButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        }
                      );
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
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
            ],
          ),
        ),
      ),
    );
  }
}
