import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:simplonmobile/entity/brief.dart';
import 'package:simplonmobile/utils/global.colors.dart';

class BriefView extends StatefulWidget {
  const BriefView({super.key});

  @override
  State<BriefView> createState() => _BriefViewState();
}

class _BriefViewState extends State<BriefView> {
  // Future<List<Brief>> fetchBriefs() async {
  //   try {
  //     var url = Uri.parse("http://192.168.9.79:3000/briefs");
  //     var response = await http.get(url);
  //     var briefs = <Brief>[];
  //     if (response.statusCode == 200) {
  //       var responseBody = response.body;
  //       // print(responseBody);
  //       if (responseBody != null) {
  //         // Check for null value
  //         var briefsJson = jsonDecode(responseBody);
  //         print("--------${briefsJson}");
  //         for (var briefJson in briefsJson) {
  //           var brief = Brief.fromJson(briefJson);
  //           // briefs.add(brief);
  //           print("--------${brief}");
  //         }
  //       }
  //       return briefs;
  //     } else {
  //       throw Exception('Failed to fetch briefs');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to fetch briefs: $e');
  //   }
  // }
  static Future<List<Brief>> fetchBriefs() async {
    var url = Uri.parse("http://192.168.9.79:3000/briefs");
    const Map<String, String> headers = {"Content-Type": "application/json"};
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    List responseList = jsonDecode(response.body);
    List<Brief> briefs = [];
    for (Map briefMap in responseList) {
      print(briefMap);
      Brief brief = Brief.fromMap(briefMap);
      briefs.add(brief);
    }
    return briefs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Briefs'),
      ),
      body: FutureBuilder(
        future: fetchBriefs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var briefs = snapshot.data as List<Brief>;
            return ListView.builder(
              itemBuilder: (context, index) {
                var brief = briefs[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 32.0, bottom: 32, left: 16.0, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          brief.titre,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          brief.contexte,
                          style: TextStyle(color: GlobalColors.textColor),
                        ),
                        Text(
                          brief.deadline.toString(),
                          style: TextStyle(color: GlobalColors.textColor),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: briefs.length,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to fetch briefs: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
