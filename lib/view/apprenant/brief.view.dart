import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:simplonmobile/models/brief.model.dart';
import 'package:flutter/services.dart' as rootBundle;

class BriefView extends StatefulWidget {
  const BriefView({super.key});

  @override
  State<BriefView> createState() => _BriefViewState();
}

class _BriefViewState extends State<BriefView> {
  Future<List<BriefModel>> fetchUsers() async {
    final data = await rootBundle.rootBundle.loadString('db/brief.json');
    final list = json.decode(data) as List<dynamic>;
    final users =
        list.map((dynamic item) => BriefModel.fromJson(item)).toList();
    return users;
  }

  @override
  void initState() {
    fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: fetchUsers(),
      builder: (context, AsyncSnapshot<List<BriefModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue, Colors.purple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.0),
                        ),
                      ),
                      child: Center(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            snapshot.data![index].image.toString(),
                          ),
                          radius: 50.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data![index].titre.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Icon(Icons.phone, size: 16.0, color: Colors.grey),
                              SizedBox(width: 8.0),
                              Text(
                                '+1 123 456 7890',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Icon(Icons.group, size: 16.0, color: Colors.grey),
                              SizedBox(width: 8.0),
                              Text(
                                snapshot.data![index].deadline.toString(),
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Icon(Icons.email, size: 16.0, color: Colors.grey),
                              SizedBox(width: 8.0),
                              Text(
                                snapshot.data![index].contexte.toString(),
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
