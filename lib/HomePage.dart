import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var jsonData;
var bpm;
var irvalue;
var spO2;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
/*
  @override
  void initState() {
    super.initState();
    getpulse();
  }
*/
  // https://api.thingspeak.com/channels/1964229/fields/1.json?api_key=TD3ZH96RZW9P04AG&results=2
  Future getpulse() async {
    var response = await http.get(Uri.https(
        'api.thingspeak.com',
        'channels/1964229/feeds.json',
        {'api_key': 'TD3ZH96RZW9P04AG', 'results': '1'}));
    //print(response.body);
    //setState(){
    jsonData = jsonDecode(response.body);
    //}
    print(jsonData['feeds'][0]['field3']);
    setState(() {
      bpm = jsonData['feeds'][0]['field1'];
      irvalue = jsonData['feeds'][0]['field2'];
      spO2 = jsonData['feeds'][0]['field3'];
    });
  }

  @override
  Widget build(BuildContext context) {
    //getpulse();
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
          //if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Text(
                          "BPM : " +
                              (bpm).toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        )),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Text(
                          "IR Value : " +
                              irvalue.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        )),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Text(
                          "SpO2 : " +
                              (spO2).toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        )),
                      ),
                    ),
                  ),/*
                  Expanded(
                    flex: 1,
                      child:GestureDetector(
                        onTap: (){
                          getpulse();
                        },
                        child: Icon(Icons.restart_alt_rounded,size: 55,),
                        ),
                      )*/
                ],
              ),
            );
          //} /*else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          //}
        },
      ),
    );
  }
}
