import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hackathon_prep/queue_db.dart';
import 'models/store.dart';

class StoresStored {
  static Map<int, Store> storesMap = new Map();
  static List<Store> storesList = new List();
  static Map<String, Store> storeFromAddressMap = new Map();
  static String adminPassword;
  static Map<int, int> queueNumsMap = new Map();

  static Future<void> initDb() async {
    final firestoreInstance = Firestore.instance;
    await firestoreInstance.collection("Stores").getDocuments().then((value) {
      value.documents.forEach((element) {
        var data = element.data;
        int id = int.parse(data["Id"]);
        String name = data["name"];
        String address = data["Address"];
        String imageUrl = data["imageUrl"];
        String restrictions = data["restrictions"];
        int occupancy = int.parse(data["occupancy"]);

        storesMap[id] = new Store(id, address, imageUrl, name, restrictions, occupancy);
        storesList.add(new Store(id, address, imageUrl, name, restrictions, occupancy));
        storeFromAddressMap[address] =
            new Store(id, address, imageUrl, name, restrictions, occupancy);

        print(
            "id: $id, name:$name, address:$address, imageUrl:$imageUrl, restrictions:$restrictions");
      });
    });
    DocumentSnapshot snapshot = await firestoreInstance
        .collection("adminPassword")
        .document("password")
        .get();
    adminPassword = snapshot.data["password"];
    print(adminPassword);

    final db = QueueDb();
    await db.initBox();

    db.box.keys.forEach((element) async {
      queueNumsMap[element] = await db.getQueueNum(element);
    });
  }

  static int getNumInQueue(AsyncSnapshot snapshot, int storeId) {
    DocumentSnapshot documentSnapshot = snapshot.data.documents[storeId-1];

    return int.parse(documentSnapshot.data["numLinedUp"]);
  }

  static int getNumBeingCalled(AsyncSnapshot snapshot, int storeId) {
    DocumentSnapshot documentSnapshot = snapshot.data.documents[storeId-1];

    return int.parse(documentSnapshot.data["numBeingCalled"]);
  }

  static void incrementNumInQueue(AsyncSnapshot snapshot, int storeId) {
    print(snapshot.data);
    DocumentSnapshot documentSnapshot = snapshot.data.documents[storeId-1];
    documentSnapshot.reference.updateData({
      "numLinedUp": "${int.parse(documentSnapshot.data["numLinedUp"]) + 1}"
    });
  }

  static void decrementNumInQueue(AsyncSnapshot snapshot, int storeId) {
    print(snapshot.data);
    DocumentSnapshot documentSnapshot = snapshot.data.documents[storeId-1];
    documentSnapshot.reference.updateData({
      "numLinedUp": "${int.parse(documentSnapshot.data["numLinedUp"]) - 1}"
    });
  }

  static void incrementNumBeingCalled(AsyncSnapshot snapshot, int storeId) {
    print(snapshot.data);
    DocumentSnapshot documentSnapshot = snapshot.data.documents[storeId-1];
    documentSnapshot.reference.updateData({
      "numBeingCalled":
          "${int.parse(documentSnapshot.data["numBeingCalled"]) + 1}"
    });
  }

  static void decrementNumBeingCalled(AsyncSnapshot snapshot, int storeId) {
    print(snapshot.data);
    DocumentSnapshot documentSnapshot = snapshot.data.documents[storeId-1];
    int numBeingCalled = int.parse(documentSnapshot.data["numBeingCalled"]) - 1;
    if (numBeingCalled > 0) {
      documentSnapshot.reference
          .updateData({"numBeingCalled": "${numBeingCalled - 1}"});
    }
  }
}
