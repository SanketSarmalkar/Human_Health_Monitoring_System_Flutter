import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var jsonData;
var bpm;
var irvalue;
var spO2;
var bodyTemp;

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

    await http.post(Uri.https(
        'api.thingspeak.com',
        'channels/1964229/feeds.json',
        {'api_key': 'TD3ZH96RZW9P04AG', 'results': '1'}));
    //}
    debugPrint(jsonData['feeds'][0]['field3']);
    // setState(() {
    //   bpm = jsonData['feeds'][0]['field1'];
    //   irvalue = jsonData['feeds'][0]['field2'];
    //   spO2 = jsonData['feeds'][0]['field3'];
    // });
  }

  // time() {
  //   Timer.periodic(const Duration(seconds: 5), (timer) {
  //     setState(() {
  //       getpulse();
  //       setState(() {
  //         bpm = jsonData['feeds'][0]['field1'];
  //         irvalue = jsonData['feeds'][0]['field2'];
  //         spO2 = jsonData['feeds'][0]['field3'];
  //         bodyTemp = jsonData['feeds'][0]['field4'];
  //       });
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //getpulse();
    //time();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Human Health Monitoring System",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        )),
        backgroundColor: Colors.indigo,
        toolbarHeight: 100,
        shadowColor: Colors.deepPurpleAccent,
      ),
      body: FutureBuilder(
          future: getpulse(),
          builder: (context, snapshot) {
            //if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Colors.indigo,
                    Colors.deepPurpleAccent,
                    Colors.indigo
                  ])),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.deepPurpleAccent,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10,
                                            offset: Offset(0, 2),
                                          ),
                                        ]),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        bpm.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Beats Per Minute (BPM)",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.deepPurpleAccent,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10,
                                            offset: Offset(0, 2),
                                          ),
                                        ]),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        irvalue.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "IR Value",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.deepPurpleAccent,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10,
                                            offset: Offset(0, 2),
                                          ),
                                        ]),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        spO2.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "SpO2",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.deepPurpleAccent,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10,
                                            offset: Offset(0, 2),
                                          ),
                                        ]),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '$bodyTemp \u2103',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Body Temperature",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            bpm = jsonData['feeds'][0]['field1'];
                            irvalue = jsonData['feeds'][0]['field2'];
                            spO2 = jsonData['feeds'][0]['field3'];
                            bodyTemp = jsonData['feeds'][0]['field4'];
                          });
                        },
                        child: const Icon(
                          Icons.restart_alt_rounded,
                          size: 55,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
            // } else {
            //   return Container(
            //     child: Center(
            //       child: CircularProgressIndicator(),
            //     ),
            //   );
            // }
          }),
    );
  }
}
