import 'package:flutter/material.dart';
import 'package:hackathon_prep/local_user_type_db.dart';
import 'package:hackathon_prep/stores_stored.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await StoresStored.initDb();

  runApp(MyApp());
}

