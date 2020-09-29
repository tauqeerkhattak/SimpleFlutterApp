import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//void main () {
//  WidgetsFlutterBinding.ensureInitialized();
//  Firebase.initializeApp();
//  runApp(DataEntry());
//}

class DataEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Entry"),
        backgroundColor: Colors.blue,
      ),
      body: DataEntryBody(),
    );
  }
}

class DataEntryBody extends StatefulWidget {
  @override
  _DataEntryBodyState createState() => _DataEntryBodyState();
}

class _DataEntryBodyState extends State<DataEntryBody> {

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController dOBController = TextEditingController();
  TextEditingController mark1Controller = TextEditingController();
  TextEditingController mark2Controller = TextEditingController();
  TextEditingController mark3Controller = TextEditingController();
  TextEditingController mark4Controller = TextEditingController();
  DateTime _dateOfBirth;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    dOBController.dispose();
    mark1Controller.dispose();
    mark2Controller.dispose();
    mark3Controller.dispose();
    mark4Controller.dispose();
  }

  void _addDataEntryToFirebase (String name,String number,String dob,String mark1,String mark2,String mark3,String mark4) {
    FirebaseFirestore.instance.collection("Data Entry").doc(number).set({
      "Name": name,
      "Number": number,
      "Date of Birth": dob,
      "Mark1": mark1,
      "Mark2": mark2,
      "Mark3": mark3,
      "Mark4": mark4,
    }).then((value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Data Entry added!"),
            content: Text("Data Entry successfully added to Firebase!"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  nameController.text = "";
                  numberController.text = "";
                  dOBController.text = "";
                  mark1Controller.text = "";
                  mark2Controller.text = "";
                  mark3Controller.text = "";
                  mark4Controller.text = "";
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
      );
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("ERROR"),
            content: Text("Cannot add data to firebase, please check your internet connection or restart the application!"),
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
                  controller: nameController,
                  validator: (String name) {
                    if(name.isEmpty || name == null) {
                      return "Please enter a name!";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Name:",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
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
                  validator: (String date) {
                    if(date.isEmpty || date == null) {
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
                child: TextFormField(
                  controller: mark1Controller,
                  validator: (String mark) {
                    if(mark.isEmpty || mark == null) {
                      return "Mark1 can't be empty!";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Mark 1:",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: TextFormField(
                  controller: mark2Controller,
                  validator: (String mark) {
                    if(mark.isEmpty || mark == null) {
                      return "Mark2 can't be empty!";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Mark 2:",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: TextFormField(
                  controller: mark3Controller,
                  validator: (String mark) {
                    if(mark.isEmpty || mark == null) {
                      return "Mark3 can't be empty!";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Mark 3:",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: TextFormField(
                  controller: mark4Controller,
                  validator: (String mark) {
                    if(mark.isEmpty || mark == null) {
                      return "Mark4 can't be empty!";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Mark 4:",
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
                            content: Text("Are you sure you want to add this Data Entry?"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Sure"),
                                onPressed: () {
                                  String name = nameController.text;
                                  String number = numberController.text;
                                  String dob = dOBController.text;
                                  String m1 = mark1Controller.text;
                                  String m2 = mark2Controller.text;
                                  String m3 = mark3Controller.text;
                                  String m4 = mark4Controller.text;
                                  _addDataEntryToFirebase(name, number, dob, m1, m2, m3, m4);
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
