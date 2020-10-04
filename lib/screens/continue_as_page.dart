import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_prep/local_user_type_db.dart';
import 'package:hackathon_prep/screens/store_list_screen.dart';
import 'package:hackathon_prep/stores_stored.dart';

class ContinueAsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContinueAsPageState();
  }
}

class _ContinueAsPageState extends State<ContinueAsPage> {
  String enteredPassword = "";
  Widget wrongPasswordText = Container();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Continue as Admin/User"),
        centerTitle: true,
        backgroundColor: Colors.red[700],
      ),
      body: Container(
        child: Column(
          children: [
            _renderLabel(),
            _renderTextView(),
            wrongPasswordText,
            _renderSubmitButton(),
            _renderUserButton()
          ],
        ),
      ),
    );
  }

  Widget _renderLabel() {
    return Container(
        padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 15.0),
        child: Text(
          "Enter the appropriate code to continue as Admin:",
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ));
  }

  Widget _renderTextView() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        width: 300,
        child: TextField(
          keyboardType: TextInputType.text,
          onChanged: (input) {
            setState(() {
              enteredPassword = input;
            });
          },
        ));
  }

  Widget _renderSubmitButton() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 125.0, horizontal: 10.0),
        child: FlatButton(
          color: Colors.red,
          child: Text("Sign in as Admin"),
          onPressed: () async {
            final db = new UserTypeDb();
            if (enteredPassword == StoresStored.adminPassword) {
              await db.setUserType(UserType.admin);
              String type = await db.getUserType();
              print(type);
              var isUser = (type == "user") ? true : false;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StoreListPage(isUser)));
            } else {
              setState(() {
                wrongPasswordText = Text(
                  "The password entered was incorrect.",
                  style: TextStyle(fontSize: 15.0, color: Colors.red),
                );
              });
            }
          },
        ));
  }

  Widget _renderUserButton() {
    return FlatButton(
      child: Text("Continue as User instead"),
      onPressed: () async {
        final db = new UserTypeDb();
        await db.setUserType(UserType.user);
        String type = await db.getUserType();
        print(type);
        var isUser = (type == "user") ? true : false;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StoreListPage(isUser)));
      },
    );
  }
}
