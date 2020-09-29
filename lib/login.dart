import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_page.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue,
      ),
      body: LoginBody(),
    );
  }
}

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                  controller: _emailController,
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
                  obscureText: true,
                  validator: (String password) {
                    if (password.isEmpty || password == null) {
                      return "Password can't be empty!";
                    }
                    else if(password.length < 8) {
                      return "Password can't be less than 8 characters!";
                    }
                    return null;
                  },
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password:",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0,bottom: 0.0),
                child: FlatButton(
                  child: Text("Login"),
                  color: Colors.blue,
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return MainPage();
                            }
                        ));
                      }).catchError((error) {
                        if (error.code == 'ERROR_USER_NOT_FOUND') {
                          print(error.code);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Nothing Found!"),
                                  content: Text("No User found for the email entered!"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }
                          );
                        } else if (error.code == 'ERROR_WRONG_PASSWORD') {
                          print(error.code);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Wrong information"),
                                  content: Text("The email or password you entered is wrong!"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }
                          );
                        }
                      });
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
