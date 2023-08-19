import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:signinwithgoogle/sign_in.dart';

class ReadRecord extends StatefulWidget {
  const ReadRecord({super.key});

  @override
  State<ReadRecord> createState() => _ReadRecordState();
}

class _ReadRecordState extends State<ReadRecord> {
  @override
  void initState() {
    // TODO: implement initState
    readRecord();
  }
  List<int> ages=[];
  List<String> names=[];
  List<String> profileImages=[];

  bool isLoding=true;



  Future<void> readRecord() async{
    var dbUrl="https://signinwith-24940-default-rtdb.firebaseio.com/"+"record.json";
 try{
   final respose=await http.get(Uri.parse(dbUrl));
   final data=json.decode(respose.body) as Map<String, dynamic>;
   if(data==null)
     {
       return;
     }

   data.forEach((key, value) {
     names.add(value['name']);
     ages.add(value['age']);
     profileImages.add(value['image']);
   });
   setState(() {
     isLoding=false;
   });

 }catch(e)
    {
      print("error");
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoding?const CircularProgressIndicator():Center(
        child: ListView.builder(
          itemCount: names.length,
          itemBuilder: (context, index) {
          return ListTile(
            // leading: CircleAvatar(
            //   radius: 20,
            //   backgroundImage: NetworkImage(profileImages[index])
            // ),
            title: Text(names[index]),
            subtitle: Text("Age ${ages[index].toString()}"),
          );
        },),
      ),
    );
  }
}
