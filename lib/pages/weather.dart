import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  WeatherState createState() => WeatherState();
}

class WeatherState extends State<Weather> {
  late TextEditingController _textController;

  List<Widget> info = [];

  void showAllInfo(String name, String celsius, String fahrenheit,
      String condition, String image) {
    List<Widget> widgets = [
      Text(
        name,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
      const SizedBox(height: 10),
      Text(
        '$fahrenheit °F',
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      Text(
        '$celsius °C',
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      Text(
        condition,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 20),
      SizedBox(
        height: 130,
        width: 130,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            "https:$image",
            fit: BoxFit.cover,
          ),
        ),
      ),
    ];
    setState(() {
      info = widgets;
    });
  }

  void showInfo() async {
    if (_textController.text.isEmpty) return;
    String apiUrl =
        'https://api.weatherapi.com/v1/current.json?key=448c020477bb4b06bad73051241203&q=${_textController.text}';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        showAllInfo(
          jsonData['location']['name'],
          jsonData['current']['temp_c'].toString(),
          jsonData['current']['temp_f'].toString(),
          jsonData['current']['condition']['text'],
          jsonData['current']['condition']['icon'],
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Esta ciudad no existe, Ingrese una ciudad válida')));
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
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Clima",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            TextField(
              controller: _textController,
              onChanged: (text) {
                setState(() {});
              },
              decoration: const InputDecoration(
                  labelText: 'Ingresa el nombre de la ciudad',
                  floatingLabelAlignment: FloatingLabelAlignment.center),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: showInfo,
              child: const Text("Mostrar el clima"),
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: info,
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
