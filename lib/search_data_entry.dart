import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_flutter_app/search_result.dart';

//void main() async {
//  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
//  runApp(SearchDataEntry());
//}

class SearchDataEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Search"),
        backgroundColor: Colors.blue,
      ),
      body: SearchDataEntryBody(),
    );
  }
}

class SearchDataEntryBody extends StatefulWidget {
  @override
  _SearchDataEntryBodyState createState() => _SearchDataEntryBodyState();
}

class _SearchDataEntryBodyState extends State<SearchDataEntryBody> {

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("Data Entry");
  TextEditingController numberController = TextEditingController();
  TextEditingController dOBController = TextEditingController();
  DateTime _dateOfBirth;
  final _formKey = GlobalKey<FormState>();

  void _searchData (String number,String dob) {
    DocumentReference documentReference = collectionReference.doc(number);
    documentReference.get().then((value) {
      if(value.get("Date of Birth") == dob) {
        print(value.get("Number"));
        print(value.get("Date of Birth"));
        String name = value.get("Name");
        String number = value.get("Number");
        String dateOfBirth = value.get("Date of Birth");
        String mark1 = value.get("Mark1");
        String mark2 = value.get("Mark2");
        String mark3 = value.get("Mark3");
        String mark4 = value.get("Mark4");
        Navigator.push(context,MaterialPageRoute(
          builder: (context) {
            return SearchResult(name,number,dateOfBirth,mark1,mark2,mark3,mark4);
          }
        ));
      }
      else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Data Entry Error"),
              content: Text("The Number or Date of Birth you entered is wrong!"),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
        );
      }
    }).catchError((error) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Data Entry Error"),
              content: Text("The number you entered does not exist in Firebase!"),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
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
                  keyboardType: TextInputType.number,
                  controller: numberController,
                  validator: (String number) {
                    if(number.isEmpty || number == null) {
                      return "Please enter a number!";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Number:",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: TextFormField(
                  controller: dOBController,
                  validator: (String dob) {
                    if(dob.isEmpty || dob == null) {
                      return "Please enter a date!";
                    }
                    return null;
                  },
                  onTap: () async {
                    _dateOfBirth = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1980,1),
                      lastDate: DateTime.now(),
                    );
                    setState(() {
                      int month = _dateOfBirth.month;
                      int day = _dateOfBirth.day;
                      int year = _dateOfBirth.year;
                      dOBController.text = '$month - $day , $year';
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Date of Birth:",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: FlatButton(
                  child: Text("Search"),
                  color: Colors.blue,
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirmation"),
                            content: Text("Are you sure you want to search in our database?"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Sure"),
                                onPressed: () {
                                  String number = numberController.text;
                                  String dob = dOBController.text;
                                  _searchData(number, dob);
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
            ],
          ),
        ),
      ),
    );
  }
}
