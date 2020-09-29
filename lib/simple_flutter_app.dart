import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:simple_flutter_app/main_page.dart';
import 'login.dart';

class SimpleFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
          backgroundColor: Colors.blue,
        ),
        body: RegistrationPage(),
      ),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController houseNameController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  DateTime dateOfBirth;
  File _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void _addDataToFirebase (String name,String HName,String place,String district,String phNo,String WhNo,String DoB,String email,String password) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) => {
      FirebaseFirestore.instance.collection("Registered Users").doc(email).set({
        "Name": name,
        "House Name": HName,
        "Place": place,
        "District": district,
        "Phone Number": phNo,
        "Whatsapp Number": WhNo,
        "Date of Birth": DoB,
        "Email": email,
      }),
      if (_image != null) {
        uploadFile()
      },
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return MainPage();
        }
      )),
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Email already exist"),
            content: Text(error.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        }
      );
    });
  }

  Future uploadFile () async {
    User user = FirebaseAuth.instance.currentUser;
    String imageName = user.uid;
    StorageReference reference = FirebaseStorage.instance.ref().child(imageName);
    StorageUploadTask uploadTask = reference.putFile(_image);
    await uploadTask.onComplete;
    print("File Uploaded");
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    houseNameController.dispose();
    placeController.dispose();
    districtController.dispose();
    phoneController.dispose();
    whatsappController.dispose();
    dateController.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                  validator: (String name) {
                    if (name.isEmpty || name == null) {
                      return "Name can't be empty!";
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name:",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: TextFormField(
                  validator: (String houseName) {
                    if (houseName.isEmpty || houseName == null) {
                      return "Please Enter House Name!";
                    }
                    return null;
                  },
                  controller: houseNameController,
                  decoration: InputDecoration(
                    labelText: "House Name:",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0,left: 15.0,right: 7.5,bottom: 0.0),
                      child: TextFormField(
                        validator: (String place) {
                          if (place.isEmpty || place == null) {
                            return "Place can't be empty!";
                          }
                          return null;
                        },
                        controller: placeController,
                        decoration: InputDecoration(
                          labelText: "Place:",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0,left: 7.5,right: 15.0,bottom: 0.0),
                      child: TextFormField(
                        validator: (String district) {
                          if (district.isEmpty || district == null) {
                            return "District can't be empty!";
                          }
                          return null;
                        },
                        controller: districtController,
                        decoration: InputDecoration(
                          labelText: "District:",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: TextFormField(
                  validator: (String phone) {
                    if (phone.isEmpty || phone == null) {
                      return "Phone can't be empty!";
                    }
                    else if(phone.length < 10) {
                      return "Please enter a valid phone number!";
                    }
                    return null;
                  },
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Phone Number:",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: TextFormField(
                  validator: (String whatsapp) {
                    if (whatsapp.isEmpty || whatsapp == null) {
                      return "Whatsapp number can't be empty!";
                    }
                    else if(whatsapp.length < 10) {
                      return "Please enter a valid whatsapp number!";
                    }
                    return null;
                  },
                  controller: whatsappController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Whatsapp No:",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: TextFormField(
                  validator: (String date) {
                    if (date.isEmpty || date == null) {
                      return "Date can't be empty!";
                    }
                    return null;
                  },
                  controller: dateController,
                  onTap: () async {
                    dateOfBirth = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1980,1),
                      lastDate: DateTime.now(),
                    );
                    setState(() {
                      int month = dateOfBirth.month;
                      int day = dateOfBirth.day;
                      int year = dateOfBirth.year;
                      dateController.text = '$day - $month - $year';
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Date of Birth:",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0,bottom: 0.0),
                      child: _image == null?Text("Upload Image: "):Text(_image.path.substring(_image.path.lastIndexOf("/"))),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0,bottom: 0.0),
                      child: FloatingActionButton(
                        tooltip: "Upload Image",
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Select From: "),
                                  content: Text("Please choose where to select the image from: "),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Camera"),
                                      onPressed:() {
                                        getImageFromCamera();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("Gallery"),
                                      onPressed: () {
                                        getImageFromGallery();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              }
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: TextFormField(
                  validator: (String email) {
                    if (email.isEmpty || email == null) {
                      return "Email can't be empty!";
                    }
                    else if(!(email.contains("@"))) {
                      return "Please enter a valid email!";
                    }
                    else if (!(email.contains(".com"))) {
                      return "Please enter a valid email!";
                    }
                    return null;
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email:",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: TextFormField(
                  validator: (String password) {
                    if (password.isEmpty || password == null) {
                      return "Password can't be empty!";
                    }
                    else if(password.length < 8) {
                      return "Length of password must be equal or greater than 8!";
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password:",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0,bottom: 5.0),
                child: FlatButton(
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirmation"),
                            content: Text("Are you sure you want to register with this information?"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Sure"),
                                onPressed: () {
                                  String name = nameController.text;
                                  String houseName = houseNameController.text;
                                  String place = placeController.text;
                                  String district = districtController.text;
                                  String phone = phoneController.text;
                                  String whatsapp = whatsappController.text;
                                  String dOB = dateOfBirth.toString();
                                  String email = emailController.text.trim();
                                  String password = passwordController.text;
                                  _addDataToFirebase(name,houseName,place,district,phone,whatsapp,dOB,email,password);
                                  Navigator.pop(context);
                                },
                              ),
                              FlatButton(
                                child: Text("No"),
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
                margin: EdgeInsets.only(top: 5.0,left: 15.0,right: 15.0,bottom: 10.0),
                child: FlatButton(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Login();
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
