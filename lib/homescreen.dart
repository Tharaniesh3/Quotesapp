import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  late String quote = "";
  late String author = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Quotes",
              style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                quote,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "- $author",
                    style: TextStyle(fontSize: 15),
                  )),
            ),
            ElevatedButton(
              onPressed: () async {
                var url = Uri.parse(
                    'https://goquotes-api.herokuapp.com/api/v1/random?count=1');
                var response = await http.get(url);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');
                var data = jsonDecode(response.body);
                quote = data["quotes"][0]["text"];
                author = data["quotes"][0]["author"];
                setState(() {});
              },
              child: Text("Quotes"),
            ),
          ],
        ),
      ),
    );
  }
}
