import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var jsonData;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  // https://api.thingspeak.com/channels/1964229/fields/1.json?api_key=TD3ZH96RZW9P04AG&results=2
  Future getpulse() async {
    var response = await http.get(Uri.https(
        'api.thingspeak.com',
        'channels/1964229/feeds.json',
        {'api_key': 'TD3ZH96RZW9P04AG', 'results': '1'}));
    //print(response.body);
    jsonData = jsonDecode(response.body);
    print(jsonData['feeds'][0]['field3']);
  }

  @override
  Widget build(BuildContext context) {
    getpulse();
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Human Health Monitoring System",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        )),
        backgroundColor: Colors.indigo,
        toolbarHeight: 100,
      ),
      body: FutureBuilder(
        future: getpulse(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Text(
                          "BPM : " + (jsonData["feeds"][0]["field1"]).toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        )),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Text(
                          "IR Value : " +
                              jsonData["feeds"][0]["field2"].toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        )),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Text(
                          "SpO2 : " + (jsonData["feeds"][0]["field3"]).toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
