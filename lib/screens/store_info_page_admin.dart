import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_prep/models/store.dart';

import '../stores_stored.dart';
import '../stores_stored.dart';

class StoreInfoPageAdmin extends StatelessWidget {
  final Store store;

  StoreInfoPageAdmin(this.store);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("${store.name}"),
          centerTitle: true,
          backgroundColor: Colors.red[700],
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection("Queue").snapshots(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: _getImage(store.imageUrl, 250.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      decrementButton(snapshot),
                      _displayNumBeingCalled(snapshot),
                      _displayNumLinedUp(snapshot),
                      incrementButton(snapshot)
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "${store.address}",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "${store.restrictions}",
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                 /* Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Total amount lined up: ${StoresStored.getNumInQueue(snapshot, this.store.id)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Number being called:  ${StoresStored.getNumBeingCalled(snapshot, this.store.id)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: FloatingActionButton(
                      child: Text(
                        "Increase number being called",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        StoresStored.incrementNumBeingCalled(
                            snapshot, this.store.id);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: FloatingActionButton(
                        child: Text(
                          "Decrease number being called",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          StoresStored.decrementNumBeingCalled(
                              snapshot, this.store.id);
                        }),
                  ), */
                ],
              ),
            );
          },
        ));
  }

  Widget _displayNumBeingCalled(AsyncSnapshot snapshot) {
    return Container(
      padding: EdgeInsets.all(10.0),
        child: Column(
      children: [
        Text(
          "Now Calling:",
          style: TextStyle(fontSize: 15.0),
        ),
        Text(
          "${StoresStored.getNumBeingCalled(snapshot, this.store.id)}",
          style: TextStyle(fontSize: 20.0),
        )
      ],
    ));
  }

  Widget _displayNumLinedUp(AsyncSnapshot snapshot) {
    return Container(
      padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "Queue length:",
              style: TextStyle(fontSize: 15.0),
            ),
            Text(
              "${StoresStored.getNumInQueue(snapshot, this.store.id)}",
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ));
  }

  Widget incrementButton(AsyncSnapshot snapshot){
    return FlatButton(
        child: Text(
          "+",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
            fontSize: 20,
          ),
        ),
        onPressed: () {
          StoresStored.incrementNumBeingCalled(
              snapshot, this.store.id);
        });
  }

  Widget decrementButton(AsyncSnapshot snapshot){
    return FlatButton(
        child: Text(
          "-",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
            fontSize: 20,
          ),
        ),
        onPressed: () {
          StoresStored.decrementNumBeingCalled(
              snapshot, this.store.id);
        });
  }

  Widget _getImage(String url, double height) {
    return Container(
      constraints: BoxConstraints.tightFor(height: height),
      child: Image.network(url, fit: BoxFit.fitWidth),
    );
  }
}
