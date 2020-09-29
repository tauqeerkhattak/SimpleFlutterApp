import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String _name,_number,_dateofBirth,_mark1,_mark2,_mark3,_mark4;
TextEditingController _nameController = TextEditingController();
TextEditingController _numberController = TextEditingController();
TextEditingController _dobController = TextEditingController();
TextEditingController _mark1Controller = TextEditingController();
TextEditingController _mark2Controller = TextEditingController();
TextEditingController _mark3Controller = TextEditingController();
TextEditingController _mark4Controller = TextEditingController();

class SearchResult extends StatelessWidget {

  SearchResult(String name,number,dateofBirth,mark1,mark2,mark3,mark4) {
    _name = name;
    _number = number;
    _dateofBirth = dateofBirth;
    _mark1 = mark1;
    _mark2 = mark2;
    _mark3 = mark3;
    _mark4 = mark4;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Search Result"),
          backgroundColor: Colors.blue,
        ),
        body: SearchResultBody(),
      ),
    );
  }
}

class SearchResultBody extends StatefulWidget {
  @override
  _SearchResultBodyState createState() => _SearchResultBodyState();
}

class _SearchResultBodyState extends State<SearchResultBody> {

  void setData () {
    setState(() {
      _nameController.text = _name;
      _numberController.text = _number;
      _dobController.text = _dateofBirth;
      _mark1Controller.text = _mark1;
      _mark2Controller.text = _mark2;
      _mark3Controller.text = _mark3;
      _mark4Controller.text = _mark4;
    });
  }

  @override
  Widget build(BuildContext context) {

    setData();

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
              child: TextFormField(
                readOnly: true,
                enableInteractiveSelection: false,
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name:",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
              child: TextFormField(
                readOnly: true,
                enableInteractiveSelection: false,
                controller: _numberController,
                decoration: InputDecoration(
                  labelText: "Number:",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
              child: TextFormField(
                readOnly: true,
                enableInteractiveSelection: false,
                controller: _dobController,
                decoration: InputDecoration(
                  labelText: "Date of Birth:",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
              child: TextFormField(
                readOnly: true,
                enableInteractiveSelection: false,
                controller: _mark1Controller,
                decoration: InputDecoration(
                  labelText: "Mark 1:",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
              child: TextFormField(
                readOnly: true,
                enableInteractiveSelection: false,
                controller: _mark2Controller,
                decoration: InputDecoration(
                  labelText: "Mark 2:",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
              child: TextFormField(
                readOnly: true,
                enableInteractiveSelection: false,
                controller: _mark3Controller,
                decoration: InputDecoration(
                  labelText: "Mark 3:",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,bottom: 0.0),
              child: TextFormField(
                readOnly: true,
                enableInteractiveSelection: false,
                controller: _mark4Controller,
                decoration: InputDecoration(
                  labelText: "Mark 4:",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
