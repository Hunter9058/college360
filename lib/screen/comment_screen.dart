import 'package:college360/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class Comment extends StatefulWidget {
  final Stream<List<CommentModel>>? commentStream;
  static const String id = 'comment_screen';
  Comment({
    this.commentStream,
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
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: comment.length,
                      itemBuilder: (context, index) {
                        return Column(
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
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              comment[index].comment,
                              style: TextStyle(color: Colors.white70),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Divider(
                                indent: 50,
                                endIndent: 50,
                                color: Colors.white30,
                              ),
                            ),
                          ],
                        );
                      }),
                  //post comment row
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TextField(
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
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: KBorderRadius),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: KBorderRadius,
                                  borderSide: BorderSide(color: KActionColor),
                                )),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        color: KActionColor,
                        onPressed: () {
                          try {
                            messageTextController.clear();
                            //todo comment add comment add function in database.dart
                            // _firestore.collection('messages').add(
                            //   {
                            //     'text': messageText,
                            //     'Sender': loggedInUser.email,
                            //   },
                            // );
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
    //todo copy chat360 code for list view
  }
}
