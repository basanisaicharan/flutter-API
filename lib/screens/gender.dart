// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Genderapi extends StatefulWidget {
  @override
  State<Genderapi> createState() => _MyAppState();
}

class _MyAppState extends State<Genderapi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gender Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GenderFinder(),
    );
  }
}

class GenderFinder extends StatefulWidget {
  @override
  _GenderFinderState createState() => _GenderFinderState();
}

class _GenderFinderState extends State<GenderFinder> {
  TextEditingController _nameController = TextEditingController();
  String _gender = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gender Finder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Enter Name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _fetchGender();
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            Text(
              'Gender: $_gender',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  _fetchGender() async {
    String name = _nameController.text;

    if (name.isNotEmpty) {
      final response =
          await http.get(Uri.parse('https://api.genderize.io/?name=$name'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String gender = data['gender'];
        double probability = data['probability'] * 100;

        setState(() {
          _gender = '$gender (${probability.toStringAsFixed(2)}%)';
        });
      } else {
        setState(() {
          _gender = 'Error';
        });
      }
    } else {
      setState(() {
        _gender = 'Please enter a name';
      });
    }
  }
}
