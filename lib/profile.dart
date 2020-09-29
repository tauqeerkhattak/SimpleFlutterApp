import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//void main() async {
//  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
//  runApp(Profile());
//}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.blue,
      ),
      body: ProfileBody(),
    );
  }
}

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}


class _ProfileBodyState extends State<ProfileBody> {

  CollectionReference reference = FirebaseFirestore.instance.collection("Registered Users");
  var storageInstance = FirebaseStorage.instance;
  User firebaseUser = FirebaseAuth.instance.currentUser;
  String url;
  TextEditingController nameController = TextEditingController();
  TextEditingController houseNameController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  
  void getImage () async {
    String uid = firebaseUser.uid;
    final ref = storageInstance.ref().child(uid);
    url =  await ref.getDownloadURL();
  }

  void _retrieveData () {
    DocumentReference document = reference.doc(firebaseUser.email);
    document.get().then((value) {
      if(value != null) {
        setState(() {
          print(value.get("Name"));
          nameController.text = value.get("Name");
          houseNameController.text = value.get("House Name");
          placeController.text = value.get("Place");
          districtController.text = value.get("District");
          phoneController.text = value.get("Phone Number");
          whatsappController.text = value.get("Whatsapp Number");
          dateController.text = value.get("Date of Birth");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getImage();
    _retrieveData();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: CircleAvatar(
                      backgroundImage: (url != null)?NetworkImage(url):NetworkImage("https://www.lifewire.com/thmb/3VYl4Wjelj1vF6XBgQ_CTeFIolI=/1354x1354/filters:fill(auto,1)/warningicon-5681bc863df78ccc15b5b09f.png"),
                      backgroundColor: Colors.blue,
                      radius: 70,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
              child: TextFormField(
                readOnly: true,
                enableInteractiveSelection: false,
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name:",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
              child: TextFormField(
                readOnly: true,
                enableInteractiveSelection: false,
                controller: houseNameController,
                decoration: InputDecoration(
                  labelText: "House Name:",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
              child: TextFormField(
                readOnly: true,
                enableInteractiveSelection: false,
                controller: placeController,
                decoration: InputDecoration(
                  labelText: "Place:",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
              child: TextFormField(
                readOnly: true,
                enableInteractiveSelection: false,
                controller: districtController,
                decoration: InputDecoration(
                  labelText: "District:",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
              child: TextFormField(
                readOnly: true,
                enableInteractiveSelection: false,
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "Phone Number:",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
              child: TextFormField(
                readOnly: true,
                enableInteractiveSelection: false,
                controller: whatsappController,
                decoration: InputDecoration(
                  labelText: "Whatsapp Number:",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 10.0),
              child: TextFormField(
                readOnly: true,
                enableInteractiveSelection: false,
                controller: dateController,
                decoration: InputDecoration(
                  labelText: "Date of Birth:",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
