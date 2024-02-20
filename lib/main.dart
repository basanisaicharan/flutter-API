import 'package:flutter/material.dart';
import 'package:flutterapi/screens/boredapi.dart';
import 'package:flutterapi/screens/cat.dart';
import 'package:flutterapi/screens/dog.dart';
import 'package:flutterapi/screens/gender.dart';
import 'package:flutterapi/screens/nationalize.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'List of API',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.purple[200],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cat()),
                  );
                },
                child: const Text(
                  'Cat Fact',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.purple[200],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Boredapi()),
                  );
                },
                child: const Text('Bored',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.purple[200],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Agifi()),
                  );
                },
                child: const Text('Nationalize.io',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.purple[200],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Genderapi()),
                  );
                },
                child: const Text(' Genderize.io',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.purple[200],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dog()),
                  );
                },
                child: const Text('dog.ceo',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
