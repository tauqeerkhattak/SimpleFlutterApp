import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//void main () async {
//  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
//  runApp(NotificationViewScreen());
//}

class NotificationViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications View"),
        backgroundColor: Colors.blue,
      ),
      body: NotificationViewBody(),
    );
  }
}

class NotificationViewBody extends StatefulWidget {
  @override
  _NotificationViewBodyState createState() => _NotificationViewBodyState();
}

class _NotificationViewBodyState extends State<NotificationViewBody> {

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.docs.map((doc) =>
        new ListTile(
          title: new Text(doc.get("Title")+"  Dated: "+doc.id),
          subtitle: new Text(doc.get("Description")),
        )
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Notifications").orderBy("Date",descending: true).snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return new Text("END");
          }
          return new ListView(
            children: getExpenseItems(snapshot)
          );
        },
      ),
    );
  }
}
