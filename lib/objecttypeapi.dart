import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ObjectTypeApiScreen extends StatefulWidget {
  const ObjectTypeApiScreen({super.key});

  @override
  State<ObjectTypeApiScreen> createState() => _ObjectTypeApiScreenState();
}

class _ObjectTypeApiScreenState extends State<ObjectTypeApiScreen> {
  dynamic model;
  Future<dynamic> getObjectTypeApi() async {
    try {
      var response =
          await http.get(Uri.parse('https://reqres.in/api/users?delay=3'));
      if (response.statusCode == 200) {
        model = json.decode(response.body.toString());
        print(model);
        return model;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var getdata = getObjectTypeApi();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('objecttype api'),
      ),
      body: getObjectTypeApi() == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Text(model["page"].toString()),
                Text(model["per_page"].toString()),
                Text(model["total_pages"].toString()),
                Expanded(
                  child: ListView.builder(
                    itemCount: model["data"].length,
                    itemBuilder: (context, index) {
                      var mylistt = model["data"][index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(mylistt["avatar"].toString()),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(mylistt["id"].toString()),
                                Text(mylistt["email"].toString()),
                                Text(mylistt["first_name"].toString()),
                                Text(mylistt["last_name"].toString()),
                              ],
                            ),
                          ),

                          //also same we can access through futurebuilder
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: FutureBuilder(
                    future: getObjectTypeApi(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var mydataaa = snapshot.data!;
                        return ListView.builder(
                          itemCount: mydataaa["data"].length,
                          itemBuilder: (context, index) {
                            var futuredatalist = mydataaa["data"][index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        futuredatalist["avatar"].toString()),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(futuredatalist["id"].toString()),
                                      Text(futuredatalist["email"].toString()),
                                      Text(futuredatalist["first_name"]
                                          .toString()),
                                      Text(futuredatalist["last_name"]
                                          .toString()),
                                    ],
                                  ),
                                ),

                                //also same we can access through futurebuilder
                              ],
                            );
                          },
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                )
              ],
            ),
    );
  }
}
