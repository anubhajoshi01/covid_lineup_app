import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_prep/models/store.dart';
import 'package:hackathon_prep/stores_stored.dart';

import '../queue_db.dart';

class StoreInfoPageUser extends StatefulWidget {
  final Store store;

  StoreInfoPageUser(this.store);

  @override
  State<StatefulWidget> createState() {
    return _StoreInfoPageUserState();
  }
}

class _StoreInfoPageUserState extends State<StoreInfoPageUser> {
  int queueNum;
  bool booking;

  @override
  void initState() {
    queueNum = StoresStored.queueNumsMap[this.widget.store.id];
    booking = queueNum == null || queueNum == 0;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("${this.widget.store.name}"),
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
                      child: _getImage(this.widget.store.imageUrl, 250.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _diaplayUserNumber(snapshot),
                        _displayNumBeingCalled(snapshot)
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "${this.widget.store.address}",
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
                        "${this.widget.store.restrictions}",
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                    (booking)
                        ? _renderBookButton(snapshot)
                        : _renderCancelButton(snapshot)
                    /*Column(
                      children: <Widget>[
                        Text('number being called ${StoresStored
                            .getNumBeingCalled(
                            snapshot, this.widget.store.id)}'),
                        FlatButton(
                          child: Text('book'),
                          onPressed: () {
                            StoresStored.incrementNumInQueue(snapshot, this
                                .widget
                                .store.id);
                            int queueLength = StoresStored.getNumInQueue(
                                snapshot, this.widget.store.id);
                            final QueueDb db = new QueueDb();
                            db.addStoreToQueue(this.widget.store.id,
                                queueLength + 1);
                            setState(() {
                              queueNum = queueLength + 1;
                            });
                          },
                        ),
                        FlatButton(
                          onPressed: () {
                            StoresStored.decrementNumInQueue(snapshot, this
                                .widget.store.id);
                            final QueueDb db = new QueueDb();
                            db.addStoreToQueue(this.widget.store.id, null);
                          },
                          child: Text('Cancel'),
                        ),
                        queueNum != 0 && queueNum != null ? Text(
                            'your number is $queueNum') : Text(
                            'There is no one in line'),
                      ],
                    ), */
                  ] //widgets
                  ),
            );
          },
        ));
  }

  Widget _displayNumBeingCalled(AsyncSnapshot snapshot) {
    return Container(
        child: Column(
      children: [
        Text(
          "Now Calling:",
          style: TextStyle(fontSize: 20.0),
        ),
        Text(
          "${StoresStored.getNumBeingCalled(snapshot, this.widget.store.id)}",
          style: TextStyle(fontSize: 30.0),
        )
      ],
    ));
  }

  Widget _diaplayUserNumber(AsyncSnapshot snapshot) {
    String num = queueNum != null && queueNum != 0 ? "$queueNum" : "NA";
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "Your number:",
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              num,
              style: TextStyle(fontSize: 30.0),
            )
          ],
        ));
  }

  Widget _renderBookButton(AsyncSnapshot snapshot) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: FlatButton(
          child: Text('Book'),
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          color: Colors.red,
          onPressed: () {
            StoresStored.incrementNumInQueue(snapshot, this.widget.store.id);
            int queueLength =
                StoresStored.getNumInQueue(snapshot, this.widget.store.id);
            final QueueDb db = new QueueDb();
            db.addStoreToQueue(this.widget.store.id, queueLength + 1);
            setState(() {
              queueNum = queueLength + 1;
              booking = false;
            });
          },
        ));
  }

  Widget _renderCancelButton(AsyncSnapshot snapshot) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          color: Colors.red,
          onPressed: () {
            StoresStored.decrementNumInQueue(snapshot, this.widget.store.id);
            final QueueDb db = new QueueDb();
            db.addStoreToQueue(this.widget.store.id, null);

            setState(() {
              booking = true;
            });
          },
          child: Text('Cancel'),
        ));
  }

  Widget _getImage(String url, double height) {
    return Container(
      constraints: BoxConstraints.tightFor(height: height),
      child: Image.network(url, fit: BoxFit.fitWidth),
    );
  }
}
