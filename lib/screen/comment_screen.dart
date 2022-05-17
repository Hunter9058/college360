import 'package:college360/models/comment.dart';
import 'package:college360/models/user.dart';
import 'package:college360/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class Comment extends StatefulWidget {
  final dynamic commentStream;

  //current user UID
  final String? currentUser;
  final postDocumentName;
  static const String id = 'comment_screen';

  Comment({
    this.postDocumentName,
    this.commentStream,
    //todo update with offline save current user
    this.currentUser,
  });

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  String messageText = '';
  final messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<CommentModel>>.value(
      value: widget.commentStream,
      initialData: [],
      child: Builder(builder: (context) {
        final comment = Provider.of<List<CommentModel>>(context);
        return Scaffold(
          backgroundColor: KBackGroundColor,
          appBar: AppBar(
            backgroundColor: KBackGroundColor,
            automaticallyImplyLeading: false,
            title: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 18, letterSpacing: 1.0),
                children: [
                  TextSpan(
                    text: 'Comments ',
                    style: TextStyle(
                      color: KActionColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(
                      text: '(${comment.length.toString()})',
                      style: TextStyle(color: Colors.grey))
                ],
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close))
            ],
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ScrollConfiguration(
                    //to remove scroll glow effect
                    behavior: MyBehavior(),
                    //create a comment (pic,user name,comment.comment age)
                    child: Expanded(
                      child: ListView.separated(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: comment.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 20,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            comment[index].commenterPic),
                                        radius: 19,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      comment[index].commenterName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  comment[index].comment,
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(height: 2);
                        },
                        padding: EdgeInsets.symmetric(vertical: 10),
                        scrollDirection: Axis.vertical,
                      ),
                    ),
                  ),
                  //post comment row
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: TextField(
                              //text field extend on writ
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 2,
                              cursorColor: Colors.white,
                              controller: messageTextController,
                              onChanged: (value) {
                                messageText = value;
                              },
                              decoration: InputDecoration(
                                  floatingLabelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: KBorderRadius),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: KBorderRadius,
                                    borderSide: BorderSide(color: KActionColor),
                                  )),
                            ),
                          ),
                        ),
                        FutureBuilder(
                            future: DatabaseService()
                                .getUserData(widget.currentUser),
                            builder: (BuildContext context,
                                AsyncSnapshot<UserModel?> snapshot) {
                              if (!snapshot.hasData)
                                return Container(); // still loading
                              final UserModel? userData = snapshot.data;
                              return (IconButton(
                                icon: Icon(Icons.send),
                                color: KActionColor,
                                onPressed: () {
                                  try {
                                    //todo comment add comment add function in database.dart
                                    DatabaseService().addComment(
                                        widget.postDocumentName,
                                        messageText,
                                        userData?.firstName,
                                        userData?.userPic,
                                        userData?.uid);
                                    messageTextController.clear();
                                  } catch (e) {
                                    print(e);
                                  }
                                  setState(() {
                                    DatabaseService().incrementComments(
                                        widget.postDocumentName);
                                  });
                                },
                              ));
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
