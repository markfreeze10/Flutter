import 'package:flutter/material.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Text('Hello World', style: TextStyle(color: Colors.blue))),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'E',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.notes),
              label: 'W',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'E',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'W',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'P',
              backgroundColor: Colors.black),
        ],
      ),
    );
  }
}
