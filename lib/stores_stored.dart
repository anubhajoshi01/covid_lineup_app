import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'models/store.dart';

class StoresStored{

  static Map<int, Store> storesMap = new Map();
  static List<Store> storesList = new List();
  static Map<String, Store> storeFromAddressMap = new Map();
  static String adminPassword;

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
    DocumentSnapshot snapshot = await firestoreInstance.collection("adminPassword").document("password").get();
    adminPassword = snapshot.data["password"];
    print(adminPassword);
  }

  static int getNumInQueue(AsyncSnapshot snapshot, int storeId) {
     DocumentSnapshot documentSnapshot = snapshot.data.document("$storeId").get();
     return int.parse(documentSnapshot.data["numLinedUp"]);
  }

  static int getNumBeingCalled(AsyncSnapshot snapshot, int storeId){
    DocumentSnapshot documentSnapshot = snapshot.data.document("$storeId").get();
    return int.parse(documentSnapshot.data["numBeingCalled"]);
  }

  static void incrementNumInQueue(AsyncSnapshot snapshot, int storeId){
    DocumentSnapshot documentSnapshot = snapshot.data.documents("$storeId").get();
    documentSnapshot.reference.updateData({"numLinedUp" : documentSnapshot.data["numLinedUp"] + 1});
  }

  static void decrementNumInQueue(AsyncSnapshot snapshot, int storeId){
    DocumentSnapshot documentSnapshot = snapshot.data.documents("$storeId").get();
    documentSnapshot.reference.updateData({"numLinedUp" : documentSnapshot.data["numLinedUp"] - 1});
  }

  static void incrementNumBeingCalled(AsyncSnapshot snapshot, int storeId){
    DocumentSnapshot documentSnapshot = snapshot.data.documents("$storeId").get();
    documentSnapshot.reference.updateData({"numBeingCalled" : documentSnapshot.data["numBeingCalled"] + 1});
  }

  static void decrementNumBeingCalled(AsyncSnapshot snapshot, int storeId){
    DocumentSnapshot documentSnapshot = snapshot.data.documents("$storeId").get();
    documentSnapshot.reference.updateData({"numBeingCalled" : documentSnapshot.data["numBeingCalled"] - 1});
  }
}