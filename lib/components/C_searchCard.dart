import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college360/components/C_Admin.dart';
import 'package:college360/home_pages/profile.dart';
import 'package:college360/services/GlobalData.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../models/user.dart';

class SearchCard extends StatefulWidget {
  SearchCard(
      {required this.suggestions,
      required this.listHeight,
      required this.admin});
  final double listHeight;
  final List<QueryDocumentSnapshot<UserModel>> suggestions;
  final bool admin;
  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  MyService _myService = MyService();
  @override
  Widget build(BuildContext context) {
    //todo update list length for efficiency
    if (widget.suggestions.isNotEmpty)
      return Container(
        height: widget.listHeight,
        child: ListView.builder(
            itemCount: widget.suggestions.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 70,
                margin: EdgeInsets.only(top: 5, left: 8, right: 8),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: KCardTopColor,
                ),
                child: Center(
                  child: ElevatedButton(
                    onPressed: widget.admin
                        //check if current user is admin
                        ? () {
                            showAdminAlertDialog(
                                context,
                                widget.suggestions[index].data().admin,
                                widget.suggestions[index].data().uid);
                            setState(() {});
                          }
                        : () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage(
                                          userUid: widget.suggestions[index]
                                              .data()
                                              .uid,
                                        )));
                            setState(() {});
                          },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, elevation: 0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 21,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              widget.suggestions[index].data().userPic),
                          radius: 20,
                        ),
                      ),
                      title: Text(
                          "${widget.suggestions[index].data().firstName} ${widget.suggestions[index].data().lastName}"),
                      subtitle: Text(
                        //todo update with user college lvl
                        widget.suggestions[index].data().studentId ==
                                _myService.currentUser!.studentId
                            ? 'You'
                            : 'lvl 4',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              );
            }),
      );
    else
      return Container(
        child: Text(
          'no search results',
          style: TextStyle(fontSize: 18),
        ),
      );
  }
}
