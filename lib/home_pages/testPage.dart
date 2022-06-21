import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  bool up = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          padding: EdgeInsets.all(10.0),
          duration: Duration(milliseconds: 250), // Animation speed
          transform: Transform.translate(
            offset: Offset(
                0, up == true ? -100 : 0), // Change -100 for the y offset
          ).transform,
          child: Container(
            height: 50.0,
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              child: Lottie.asset('assets/Icons/cloud-download.json',
                  fit: BoxFit.fill),
              onPressed: () {
                setState(() {
                  up = !up;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
