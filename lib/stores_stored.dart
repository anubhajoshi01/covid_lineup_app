import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'models/store.dart';

class StoresStored{

  static Map<int, Store> storesMap = new Map();
  static List<Store> storesList = new List();
  static Map<String, Store> storeFromAddressMap = new Map();

  static Future<void> initDb() async{
    final firestoreInstance = Firestore.instance;
    await firestoreInstance.collection("Stores").getDocuments().then((value){
      value.documents.forEach((element) {

        var data = element.data;
        int id = int.parse(data["Id"]);
        String name = data["name"];
        String address = data["Address"];
        String imageUrl = data["imageUrl"];
        String restrictions = data["restrictions"];

        storesMap[id] = new Store(id, address, imageUrl, name, restrictions);
        storesList.add(new Store(id, address, imageUrl, name, restrictions));
        storeFromAddressMap[address] = new Store(id, address, imageUrl, name, restrictions);

        print("id: $id, name:$name, address:$address, imageUrl:$imageUrl, restrictions:$restrictions");
      });
    });
  }

 /* static Future<String> getAdminPassword() async{
    final firestoreInstance = Firestore.instance;
    await firestoreInstance.collection('adminPassword').document("password")
        .get().then((DocumentSnapshot snapshot){
          print(snapshot["password"]);
       return snapshot["password"];
    });
  } */

}