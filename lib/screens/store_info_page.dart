import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_prep/models/store.dart';

class StoreInfoPage extends StatelessWidget{

  final Store store;

  StoreInfoPage(this.store);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("${store.name}"),
      ),
      body: Container()
    );
  }


}