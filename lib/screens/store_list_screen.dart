import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_prep/screens/store_info_page_admin.dart';
import 'package:hackathon_prep/screens/store_info_page_user.dart';
import 'package:hackathon_prep/stores_stored.dart';
import '../stores_stored.dart';

class StoreListPage extends StatelessWidget {
  final bool isUser;

  StoreListPage(this.isUser);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.red[500],
          title: Text("Stores"),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection("Queue").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: StoresStored.storesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 4.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            print(index);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => (isUser)
                                        ? StoreInfoPageUser(
                                            StoresStored.storesList[index])
                                        : StoreInfoPageAdmin(
                                            StoresStored.storesList[index])));
                          },
                          title: Column(children: <Widget>[
                            Text(
                              StoresStored.storesList[index].name,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(StoresStored.storesList[index].address,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ))
                          ]),
                          leading: CircleAvatar(
                            child: Text("${StoresStored.getNumInQueue(snapshot, StoresStored.storesList[index].id)}"),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          },
        ));
  }
}
