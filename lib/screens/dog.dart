// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dog extends StatefulWidget {
  @override
  State<Dog> createState() => _DogState();
}

class _DogState extends State<Dog> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog Image Viewer',
      home: DogImageViewer(),
    );
  }
}

class DogImageViewer extends StatefulWidget {
  @override
  _DogImageViewerState createState() => _DogImageViewerState();
}

class _DogImageViewerState extends State<DogImageViewer> {
  final TextEditingController _dogNameController = TextEditingController();
  String _dogImageURL = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dog Image Viewer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _dogNameController,
              decoration: const InputDecoration(
                labelText: 'Enter Dog Name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _fetchDogImage();
              },
              child: const Text('Fetch Dog Image'),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_dogImageURL.isNotEmpty)
              Image.network(
                _dogImageURL,
                height: 200,
                width: 200,
              ),
          ],
        ),
      ),
    );
  }

  _fetchDogImage() async {
    String dogName = _dogNameController.text;

    if (dogName.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      final response = await http.get(
          Uri.parse('https://dog.ceo/api/breeds/image/random?name=$dogName'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String imageURL = data['message'];

        setState(() {
          _dogImageURL = imageURL;
        });
      } else {
        setState(() {
          _dogImageURL = 'Error fetching dog image';
        });
      }

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _dogImageURL = 'Please enter a dog name';
      });
    }
  }
}
