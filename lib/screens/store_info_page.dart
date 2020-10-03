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
        centerTitle: true,
        backgroundColor: Colors.red[700],

      ),
      body: Column(
        crossAxialAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: ExactAssetImage("assets"),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Container(
            padding: EdgeInsets.all(10),
            child: DefaultTextStyle(
              child:Container(
                child: Text("${store.address}"),
                style:TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: DefaultTextStyle(
              child: Container(
                child: Text("${store.restrictions}"),
                style:TextStyle(
                  fontSize: 50,
                  letterSpacing:3,
                ),
              ),
            ),
          ),
      ],
      ),
    );
  }
}