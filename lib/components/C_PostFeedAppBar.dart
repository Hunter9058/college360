import 'package:college360/services/database.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../screen/search_screen.dart';
import 'package:gallery_saver/gallery_saver.dart';

class PostFeedAppbar extends StatelessWidget {
  const PostFeedAppbar({
    Key? key,
    required this.screenWidth,
  }) : super(key: key);

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,

      expandedHeight: 165,

      titleSpacing: 15,
      automaticallyImplyLeading: false,
      toolbarHeight: 70,
      elevation: 4,
      title: appTitle(),
      backgroundColor: KBackGroundColor, //app bar color
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.id);
            },
            icon: Icon(
              Icons.search,
              color: KActionColor,
              size: 30,
            ),
          ),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 65),
          child: Material(
            elevation: 2,
            borderRadius: KBorderRadius,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  gradient: KCardGradiantColor,
                  border: Border.all(width: 2, color: Colors.transparent),
                  borderRadius: KBorderRadius),
              height: 90,
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//outer container
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
//left side
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Its that time of the year',
                            style:
                                TextStyle(fontSize: 10, color: Colors.white54)),
                        Text(
                          'get your Exam Timetable for lvl 4',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xffF7F2CB).withOpacity(0.8),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: KBorderRadius,
                                  ),
                                  minimumSize: Size(screenWidth / 3, 25)),
                              onPressed: () async {
                                String url = await DatabaseService()
                                    .getApkDownloadLink(
                                        'exam_schedule', 'lvl_4');
                                await GallerySaver.saveImage(
                                  url,
                                  albumName: 'College 360',
                                  toDcim: true,
                                );
                              },
                              child: Text(
                                'Download',
                                style: TextStyle(color: KSecondaryColor),
                              )),
                        )
                      ],
                    ),
//right side
                    Image.asset(
                      'assets/images/class-timetable.png',
                      color: Colors.white54,
                      width: 60,
                      height: 60,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
