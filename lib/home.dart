import 'package:couteau_app/pages/age_reveal.dart';
import 'package:couteau_app/pages/gender_reveal.dart';
import 'package:couteau_app/pages/hireme.dart';
import 'package:couteau_app/pages/news.dart';
import 'package:couteau_app/pages/universities.dart';
import 'package:couteau_app/pages/weather.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  final List<Widget> _pages = [
    const GenderReveal(),
    const AgeReveal(),
    const Universities(),
    const Weather(),
    const News(),
    const HireMe(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inicio")),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Color(int.parse('2296f32296f3', radix: 16)),
        color: Color(int.parse('2296f32296f3', radix: 16)),
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(
            Icons.face_2_outlined,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.yard_rounded,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.book,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.sunny,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.newspaper,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.contact_mail,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (i) => {
          setState(() {
            _page = i;
          }),
        },
      ),
      body: PageView(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            body: _pages[_page],
          )
        ],
      ),
    );
  }
}
