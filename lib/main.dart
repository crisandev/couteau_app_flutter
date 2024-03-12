import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Navigate to another page
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Scaffold(
                        body: Center(child: Text("hola")),
                      )),
            );
          },
          child: Image.asset('assets/images/toolkit.png'),
        ),
      ),
    ));
  }
}
