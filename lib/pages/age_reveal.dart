import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AgeReveal extends StatefulWidget {
  const AgeReveal({Key? key}) : super(key: key);

  @override
  AgeRevealState createState() => AgeRevealState();
}

class AgeRevealState extends State<AgeReveal> {
  late TextEditingController _textController;
  String imageUrl = "assets/images/ages/desconocido.png";

  void ageReveal() async {
    String apiUrl = 'https://api.agify.io/?name=${_textController.text}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['age'] < 20) {
          setState(() {
            imageUrl = 'assets/images/ages/young.png';
          });
        } else if (jsonData['age'] < 40) {
          setState(() {
            imageUrl = 'assets/images/ages/adult.png';
          });
        } else {
          setState(() {
            imageUrl = 'assets/images/ages/old.png';
          });
        }
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
      body: Center(
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
              onPressed: ageReveal,
              child: const Text("Revelar Edad"),
            ),
            SizedBox(
              height: 40,
            ),
            Image(
              image: AssetImage(imageUrl),
              height: 200,
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
