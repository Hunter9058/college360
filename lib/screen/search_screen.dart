import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/C_searchCard.dart';
import '../constant.dart';
import '../models/user.dart';
import '../services/database.dart';

class SearchScreen extends StatefulWidget {
  static const String id = 'search_screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<QueryDocumentSnapshot<UserModel>> searchResult = [];
  List<QueryDocumentSnapshot<UserModel>> result = [];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KBackGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 30,

        toolbarHeight: screenHeight * 0.13,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            children: [
              TextField(
                onChanged: (value) async {
                  if (value.isEmpty) {
                    searchResult.clear();
                  }
                  if (value.isNotEmpty)
                    result = await DatabaseService().userSearch(value);
                  setState(() {
                    searchResult = result;
                  });
                },
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    labelText: 'Search',
                    floatingLabelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: KBorderRadius),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: KBorderRadius,
                      borderSide: BorderSide(color: KActionColor),
                    )),
              ),
            ],
          ),
        ),
        backgroundColor: KBackGroundColor, //app bar color
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        height: screenHeight * 0.85,
        width: screenWidth,
        child: searchResult.isNotEmpty
            ? SingleChildScrollView(
                child: SearchCard(
                admin: false,
                suggestions: searchResult,
                listHeight: screenHeight * 0.80,
              ))
            : Center(
                child: (Text(
                  'No Search Result',
                  style: TextStyle(fontSize: 18),
                )),
              ),
      ),
    );
  }
}
