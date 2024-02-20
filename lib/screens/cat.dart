// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cat extends StatefulWidget {
  @override
  State<Cat> createState() => _CatState();
}

class _CatState extends State<Cat> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Fact Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CatFactViewer(),
    );
  }
}

class CatFactViewer extends StatefulWidget {
  @override
  _CatFactViewerState createState() => _CatFactViewerState();
}

class _CatFactViewerState extends State<CatFactViewer> {
  String _catFact = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Fact Viewer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Text(
                'Cat Fact: $_catFact',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _fetchCatFact();
              },
              child: const Text('Fetch Cat Fact'),
            ),
          ],
        ),
      ),
    );
  }

  _fetchCatFact() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('https://catfact.ninja/fact'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String fact = data['fact'];

        setState(() {
          _catFact = fact;
        });
      } else {
        setState(() {
          _catFact = 'Error fetching cat fact';
        });
      }
    } catch (error) {
      setState(() {
        _catFact = 'Error fetching cat fact';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
