import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> students = [
    {"name": "Aman", "roll": "101", "class": "10A"},
    {"name": "Riya", "roll": "102", "class": "10A"},
    {"name": "Soham", "roll": "103", "class": "10A"},
    {"name": "Priya", "roll": "104", "class": "10B"},
    {"name": "Rahul", "roll": "105", "class": "10B"},
    {"name": "Sneha", "roll": "106", "class": "10B"},
    {"name": "Kunal", "roll": "107", "class": "10C"},
    {"name": "Meera", "roll": "108", "class": "10C"},
    {"name": "Ankit", "roll": "109", "class": "10C"},
    {"name": "Simran", "roll": "110", "class": "10D"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student List")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5, // Adjust button shape
          ),
          itemCount: students.length,
          itemBuilder: (context, index) {
            return ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentDetailScreen(name: students[index]["name"]!, roll: students[index]["roll"]!, studentClass: students[index]["class"]!,),
                  ),
                );
              },
              child: Text(students[index]["name"]!),
            );
          },
        ),
      ),
    );
  }
}

class StudentDetailScreen extends StatelessWidget {
  final String name;
  final String roll;
  final String studentClass;

  StudentDetailScreen({
    required this.name,
    required this.roll,
    required this.studentClass,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Name: $name", style: TextStyle(fontSize: 22)),
            Text("Roll No: $roll", style: TextStyle(fontSize: 22)),
            Text("Class: $studentClass", style: TextStyle(fontSize: 22)),
          ],
        ),
      ),
    );
  }
}
