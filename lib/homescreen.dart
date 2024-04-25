import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
//   List<dynamic> Dataa=[];
//   Future<List> getData() async {
//
//     final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
// if(response.statusCode==200){
//  return Dataa=json.decode(response.body.toString());
//
//
// }
// else{
// return Dataa;
//   print('no data is found');
// }
//
//
//   }

List<dynamic> myListt=[];

Future<List>getMySecondApi()async{

  final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
if(
response.statusCode==200){


  myListt=json.decode(response.body.toString());
  return myListt;


}else{
  return myListt;




}

}

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
      ),
       body:FutureBuilder(
         future: getMySecondApi(),
         builder: (context, snapshot) {
         if(snapshot.hasData){

           return ListView.builder(
             itemCount:  myListt.length,
             itemBuilder: (context, index) {
               var secondlist=myListt[index];
             return Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      child: Text('${index+1}')),
                  title:Column(
                    children: [

                      Text(secondlist["userId"].toString()),
                      Text(secondlist[  "id"].toString()),
                      Text(secondlist[ "title"]),
                      Text(secondlist["body"]),


                    ],

                  ) ,
                )


               ],
             );
           },);


         }else{

           return Center(child: CircularProgressIndicator());


         }
       },)
      //
      //
      //
      //
      // FutureBuilder(future: getData(), builder:(context, snapshot) {
      //
      //   if(snapshot.hasData){
      //     var mylist=snapshot.data;
      //     return ListView.builder(
      //       itemCount:Dataa.length ,
      //
      //
      //       itemBuilder: (context, index) {
      //         print('this is dtaddddddddddddddd$Dataa');
      //         var mydata=Dataa[index];
      //         print('this is my data $mydata');
      //       return Column(
      //         children: [
      //           Text(mydata['userId'].toString(),style: TextStyle(fontSize: 20),),
      //
      //           Text(mydata["id"].toString(),style: TextStyle(fontSize: 20),),
      //
      //           Text(mydata["title"].toString(),style: TextStyle(fontSize: 20),),
      //           Text(mydata["body"].toString(),style: TextStyle(fontSize: 20),),
      //
      //
      //
      //         ],
      //       );
      //
      //     },);
      //
      //
      //
      //   }else{
      //     print('thtttttttttttttttttttttttttttttttt$Dataa');
      //
      //     return Center(child: CircularProgressIndicator());
      //
      //   }
      //
      // },),
    );
  }
}
