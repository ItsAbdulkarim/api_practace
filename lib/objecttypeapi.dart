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
  void initState() {
    // TODO: implement initState
    getObjectTypeApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var getdata = getObjectTypeApi();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('objecttype api'),
        ),
        body: getObjectTypeApi() != null
            ? Column(
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
                  //
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
                                        Text(
                                            futuredatalist["email"].toString()),
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
                  ),

                  //we can access all through future builder
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future: getObjectTypeApi(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        var snapshotdata = snapshot.data;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshotdata["page"].toString()),
                            Text(
                                'this is snap data${snapshotdata["per_page"].toString()}'),
                            Text(model["total_pages"].toString()),
                            Container(
                              height: 400,
                              child: ListView.builder(
                                itemCount: snapshotdata['data'].length,
                                itemBuilder: (context, index) {
                                  var thislast = snapshotdata['data'][index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(thislast["id"].toString()),
                                      Text(thislast["email"].toString()),
                                      Text(thislast["first_name"].toString()),
                                      Text(thislast["last_name"].toString()),
                                      Image.network(thislast["avatar"])
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      } else {
                        return Text('no record found');
                      }
                    },
                  )
                ],
              )
            : Center(child: CircularProgressIndicator()));
  }
}
