import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GenderReveal extends StatefulWidget {
  const GenderReveal({Key? key}) : super(key: key);

  @override
  GenderRevealState createState() => GenderRevealState();
}

class GenderRevealState extends State<GenderReveal> {
  late TextEditingController _textController;
  Color backgroundColor = Colors.white;

  void genderReveal() async {
    String apiUrl = 'https://api.genderize.io/?name=${_textController.text}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['gender'] == 'male') {
          setState(() {
            backgroundColor = Colors.blue;
          });
        } else {
          setState(() {
            backgroundColor = Colors.pink;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text('Error: ${response.statusCode}')));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, 
          content: Text('Error: $error')));
    }
  }

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Gender Reveal",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            TextField(
              controller: _textController,
              onChanged: (text) {
                setState(() {});
              },
              decoration: const InputDecoration(
                  labelText: 'Enter your name',
                  floatingLabelAlignment: FloatingLabelAlignment.center),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: genderReveal,
              child: const Text("Reveal Gender"),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
