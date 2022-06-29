import 'package:college360/constant.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  static const String id = 'about_screen';

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: KBackGroundColor,
          appBar: AppBar(
            centerTitle: true,
            title: appTitle(),
            backgroundColor: KBackGroundColor,
          ),
          body: Container(
            width: screenWidth,
            height: screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //text section
                Expanded(
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: RichText(
                        text: new TextSpan(
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.white60,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                                text: 'Meet the team\n behind the',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white)),
                            new TextSpan(
                                text: ' Curtain',
                                style: new TextStyle(
                                    color: KActionColor,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    '\n\nWe are just a group of friends from BIS Helwan who faced'
                                    ' the same problem every college student face AKA '
                                    'balancing education and living a little so we decided to '
                                    'build these app to help you in times when you need to pull an all '
                                    'nighter or miss on the fun for the exams, from the entire college 360 team we wish you good luck'
                                    'with your college years and most importantly don\'t forget to have '),
                            TextSpan(
                                text: 'fun.\n\n',
                                style: TextStyle(
                                    color: KActionColor, fontSize: 15)),
                            TextSpan(
                                text:
                                    'Mohamed Hany        Ayman Abdu        Nagi Mohamed\n'
                                    'Omnia Ayman           Nada Ahmed       Salah Ahmed',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'AlexBrush',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17))
                          ],
                        ),
                      )),
                ),

                Expanded(
                  //team image section
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.transparent),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                      child: Image.asset(
                        'assets/images/college360_team.jpg',
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
