import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Verses extends StatefulWidget {
  const Verses({super.key});

  @override
  State<Verses> createState() => _VersesState();
}

class _VersesState extends State<Verses> {
  List finalresult = [];
  void decodedata() async {
    String jsondata = await rootBundle.loadString("assets/json/verses.json");
    List decodedata = jsonDecode(jsondata);
    setState(() {
      finalresult = decodedata;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    decodedata();
  }

  @override
  Widget build(BuildContext context) {
     Map<String, dynamic> chapter =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(title: Text("${chapter["name"]}")),
      // body: ListView.builder(
      //   itemCount: finalresult.length,
      //   itemBuilder: (context, i) {
      //     return Card(
      //       child: ListTile(
      //         title:Text("${chapter[i]["transliteration"]}"),
      //         leading: Text("${finalresult[i]["externalId"]}"),
      //         subtitle:Text("${finalresult[i]["text"]}") ,
      //       ),
      //     );
      //   },
      // ),
      body: SingleChildScrollView(
        child: Column(
                  children: [
                    ...chapter['verses_list']
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(
                                right: 15, left: 15, top: 10, bottom: 10),
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context, 'verses_details',
                                //     arguments: e);
                              },
                              child:  Container(
                                  alignment: Alignment.center,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Colors.orangeAccent,
                                  ),
                                  child: Row(children: [
                                    Text(
                                " ${e['verse_number']}",
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(width: 20,),
                              Text("${e["text"]}"),
                                  ],)
                                ),
                              
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
      ),
    );
  }
}
