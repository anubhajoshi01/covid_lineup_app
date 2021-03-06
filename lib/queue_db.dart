import 'package:hackathon_prep/stores_stored.dart';
import 'package:hive/hive.dart';

class QueueDb{

  Box box;


  static Future<QueueDb> getDb() async{
    final db = QueueDb();
    db.initBox();
    return db;
  }

  Future<void> initBox() async {
    if (this.box == null) {
      this.box = await Hive.openBox("queue");
    }
  }

  Future<void> addStoreToQueue(int storeId, int num) async{
    await this.initBox();
    StoresStored.queueNumsMap[storeId] = num;
    return await this.box.put(storeId, num);
  }

  Future<int> getQueueNum(int storeId) async{
    await this.initBox();
    return await this.box.get(storeId);
  }


  void delete() async {
    return this.box.delete("queue");
  }

  bool isEmpty() {
    return this.box.isEmpty;
  }


}