import 'dart:convert';
import 'dart:math';

import 'package:bhagvad_gita/view/screens/verses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => BhagvadGita(),
      "verses": (context) => Verses(),
    },
    initialRoute: "/",
  ));
}

class BhagvadGita extends StatefulWidget {
  const BhagvadGita({super.key});

  @override
  State<BhagvadGita> createState() => _BhagvadGitaState();
}

class _BhagvadGitaState extends State<BhagvadGita> {
  List finalresult = [];
  void decodeData() async {
    String jsondata = await rootBundle.loadString("assets/json/chapters.json");
    List decodedata = jsonDecode(jsondata);
    setState(() {
      finalresult = decodedata;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    decodeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bhagvad Gita"),
      ),
      body: ListView.builder(
          itemCount: finalresult.length,
          itemBuilder: (context, i) {
            return Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "verses",arguments: finalresult[i]);
                },
                leading: Text("${finalresult[i]["chapter_number"]}"),
                title: Text("${finalresult[i]["image_name"]}"),
                trailing: Text("verses:${finalresult[i]["verses_count"]}"),
                subtitle: Text("${finalresult[i]["name"]}"),
              ),
            );
          }),
    );
  }
}
