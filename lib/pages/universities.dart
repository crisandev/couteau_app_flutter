import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Universities extends StatefulWidget {
  const Universities({Key? key}) : super(key: key);

  @override
  UniversitiesState createState() => UniversitiesState();
}

class UniversitiesState extends State<Universities> {
  late TextEditingController _textController;
  String imageUrl = "assets/images/ages/desconocido.png";

  List<Widget> universities = [];

  void showAllUniversities(List listUniversities) {
    for (var element in listUniversities) {
      setState(() {
        universities.add(Card(
          child: ListTile(title: Text(element['name'])),
        ));
      });
    }
  }

  void showUniversities() async {
    if(_textController.text.isEmpty) return;
    String apiUrl =
        'http://universities.hipolabs.com/search?country=${_textController.text}';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        showAllUniversities(jsonData);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text('Error: ${response.statusCode}')));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text('Error: $error')));
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Revelador de Edad",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            TextField(
              controller: _textController,
              onChanged: (text) {
                setState(() {});
              },
              decoration: const InputDecoration(
                  labelText: 'Ingresa tu Nombre',
                  floatingLabelAlignment: FloatingLabelAlignment.center),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: showUniversities,
              child: const Text("Revelar Edad"),
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: universities,
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
