import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  List<Widget> news = [];

  @override
  void initState() {
    super.initState();
    showNews();
  }

  void showNews() async {
    String apiUrl = "https://mejorconsalud.as.com/wp-json/wp/v2/posts";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      final jsonData = json.decode(response.body);
      print(jsonData[0]['yoast_head_json']);
      for (var i = 0; i < 3; i++) {
        setState(() {
          news.add(Card(
            elevation: 5,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                          jsonData[i]['yoast_head_json']['og_image'][0]['url']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jsonData[i]['yoast_head_json']['title'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        jsonData[i]['yoast_head_json']['og_description']
                            .toString(),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _launchURL(jsonData[i]['link']),
                        child: Text(jsonData[i]['link'],
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ));
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text('Error: $error')));
    }
  }

  void _launchURL(String link) async {
    final Uri url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir la URL: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Mejor Con Salud",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink)),
          const Image(image: AssetImage("assets/images/mejor_con_salud.png"), height: 300,),
          Column(
            children: news,
          )
        ],
      ),
    );
  }
}
