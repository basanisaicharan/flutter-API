// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Agifi extends StatefulWidget {
  @override
  State<Agifi> createState() => _AgifiState();
}

class _AgifiState extends State<Agifi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nationality Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NationalityFinder(),
    );
  }
}

class NationalityFinder extends StatefulWidget {
  @override
  _NationalityFinderState createState() => _NationalityFinderState();
}

class _NationalityFinderState extends State<NationalityFinder> {
  TextEditingController _nameController = TextEditingController();
  List<String> _nationalities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nationality Finder'),
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
                _fetchNationality();
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            if (_nationalities.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nationalities:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  for (String nationality in _nationalities)
                    Text(nationality, style: const TextStyle(fontSize: 16)),
                ],
              ),
          ],
        ),
      ),
    );
  }

  _fetchNationality() async {
    String name = _nameController.text;

    if (name.isNotEmpty) {
      final response =
          await http.get(Uri.parse('https://api.nationalize.io?name=$name'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> countries = data['country'];
        List<String> nationalities = countries.map((country) {
          String countryName = country['country_id'];
          double probability = country['probability'] * 100;
          return '$countryName (${probability.toStringAsFixed(2)}%)';
        }).toList();

        setState(() {
          _nationalities = nationalities;
        });
      } else {
        setState(() {
          _nationalities = ['Error'];
        });
      }
    } else {
      setState(() {
        _nationalities = ['Please enter a name'];
      });
    }
  }
}
