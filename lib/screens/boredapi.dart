// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Boredapi extends StatefulWidget {
  @override
  State<Boredapi> createState() => _BoredapiState();
}

class _BoredapiState extends State<Boredapi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Activity Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RandomActivityViewer(),
    );
  }
}

class RandomActivityViewer extends StatefulWidget {
  @override
  _RandomActivityViewerState createState() => _RandomActivityViewerState();
}

class _RandomActivityViewerState extends State<RandomActivityViewer> {
  String _activity = '';
  String _type = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Activity Viewer'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Random Activity:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '$_activity ($_type)',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _fetchRandomActivity();
                },
                child: const Text('Refresh Activity'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _fetchRandomActivity() async {
    final response =
        await http.get(Uri.parse('https://www.boredapi.com/api/activity'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      String activity = data['activity'];
      String type = data['type'];

      setState(() {
        _activity = activity;
        _type = type;
      });
    } else {
      setState(() {
        _activity = 'Error fetching activity';
        _type = '';
      });
    }
  }
}
