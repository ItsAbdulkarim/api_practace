import 'dart:convert';

import 'package:api_practace/withmodel/withlisthomescreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Withlistandmodelscreen extends StatefulWidget {
  const Withlistandmodelscreen({super.key});

  @override
  State<Withlistandmodelscreen> createState() => _WithlistandmodelscreenState();
}

class _WithlistandmodelscreenState extends State<Withlistandmodelscreen> {
  Future<List<listModel>?> getWithForLoopapi() async {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      List<dynamic> decodedData = json.decode(response.body);
      List<listModel> list = [];
      for (var json in decodedData) {
        list.add(listModel.fromJson(json));
      }
      return list;
      print(list);
    } else {}
  }



  Future<List<listModel>?> getApiWithModel() async {
    try {
      var response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        List<dynamic> list = json.decode(response.body.toString());

        return list.map((e) => listModel.fromJson(e)).toList();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    getWithForLoopapi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<listModel>?>(
        future: getWithForLoopapi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var mylist = snapshot.data![index];

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(mylist.id.toString()),
                    Text(mylist.title.toString()),
                    Text(mylist.body.toString()),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

//
// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Center(
// child: Container(
// decoration:
// BoxDecoration(shape: BoxShape.circle, color: Colors.green),
// child: Icon(
// Icons.check,
// color: Colors.white,
// size: 150,
// )),
//
// ),
// SizedBox(height: 40,),
// Text('Congratualtions!',style: TextStyle(
// color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold
// ),),
// SizedBox(height: 20,),
// Text('Your account is ready to use.',style: TextStyle(
// color: Colors.black,fontSize: 16,
// ),),
// SizedBox(height: 40,),
// ElevatedButton(
// style: ElevatedButton.styleFrom(
// padding: EdgeInsets.symmetric(horizontal: 100,vertical: 20),
//
// backgroundColor: Colors.yellow.shade700
//
// ),
// onPressed: (){}, child: Text('Go to Home',style: TextStyle(
// color: Colors.white,letterSpacing: 2,
// )))
// ],
// ),
