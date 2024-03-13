import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HireMe extends StatelessWidget {
  const HireMe({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/foto.jpg'),
            width: 300,
            height: 300,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Cristian Sánchez',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              'scristianeulises@gmail.com',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  backgroundColor: Colors.blue,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              '@crisandev',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  backgroundColor: Colors.blue,
                  fontWeight: FontWeight.w800),
            ),
          )
        ],
      )),
    );
  }
}
