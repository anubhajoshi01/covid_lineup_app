import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_prep/screens/store_info_page.dart';
import 'package:hackathon_prep/stores_stored.dart';
import '../stores_stored.dart';



class StoreListPage extends StatelessWidget {
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
      body: ListView.builder(
        itemCount:StoresStored.storesList.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child:Card(
              child:ListTile(
                onTap:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => StoreInfoPage(StoresStored.storesList[index])));
                },
                title:Column(
                  children:<Widget>[
                    Text(
                        StoresStored.storesList[index].name,
                      style:TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                        StoresStored.storesList[index].address,
                      style:TextStyle(
                        color:Colors.grey[500],
                      )
                    )
                  ]
                ),
                leading:CircleAvatar(

                ),
              ),
            ),
          );
        }

      ),
    );
  }
}
