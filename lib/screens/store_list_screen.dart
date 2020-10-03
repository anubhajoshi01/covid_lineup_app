import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Stores"),
      ),
      body: Container(
        //change child to list view
          child: Text("First Page")
      ),
    );
  }
}
