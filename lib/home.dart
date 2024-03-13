import 'package:couteau_app/pages/age_reveal.dart';
import 'package:couteau_app/pages/gender_reveal.dart';
import 'package:couteau_app/pages/universities.dart';
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
    const Text('asdf'),
    const Text('asdf'),
    const Text('asdf'),
    // const Cover(),
    // const Character(),
    // const Moments(),
    // const About(),
    // const MyLife(),
    // const HireMe()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inicio")),
      // backgroundColor: Colors.transparent,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Color(int.parse('FFe51e22', radix: 16)),
        color: Color(int.parse('FFe51e22', radix: 16)),
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(
            Icons.face_2_outlined,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.face,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.slideshow,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.info,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.videocam,
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
