import 'dart:io';

import 'package:college360/constant.dart';
import 'package:college360/screen/about_screen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../utilityFunctions.dart';
import '../services/database.dart';
import '../wrapper.dart';

class BottomNavMenu extends StatefulWidget {
  @override
  State<BottomNavMenu> createState() => _BottomNavMenuState();
}

class _BottomNavMenuState extends State<BottomNavMenu> {
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Card(
        color: Colors.transparent,
        child: ListTile(
          onTap: () async {
            String downloadLink = await DatabaseService()
                .getApkDownloadLink('apk', 'download_link');

            openFile(
                    url: downloadLink,
                    fileName: 'college360.apk',
                    context: context)
                .then((value) => print('opening file'));
          },
          leading: CircularPercentIndicator(
            radius: 18.0,
            lineWidth: 5.0,
            percent: progress,
            center: AnimatedSwitcher(
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  ScaleTransition(
                child: child,
                scale: animation,
              ),
              duration: Duration(seconds: 1),
              child: progress == 0
                  ? new Icon(
                      Icons.download_sharp,
                      color: Colors.white,
                      size: 15,
                    )
                  : progress == 100
                      ? Lottie.asset(
                          'assets/Icons/cloud-download.json',
                          fit: BoxFit.fill,
                        )
                      : new Icon(
                          Icons.check,
                          color: KActionColor,
                          size: 18,
                        ),
            ),
            progressColor: KActionColor,
            backgroundColor: Colors.grey,
          ),
          title: Text('Update Apk version'),
        ),
      ),
      Card(
        color: Colors.transparent,
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, AboutScreen.id);
          },
          leading: Icon(
            Icons.info_outline,
            color: Colors.white,
            size: 36,
          ),
          title: Text('About us'),
        ),
      ),
      Card(
        color: Colors.transparent,
        child: ListTile(
          onTap: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, Wrapper.id);
          },
          leading: Icon(
            Icons.logout,
            color: Colors.white,
            size: 36,
          ),
          title: Text('Logout'),
        ),
      ),
    ]);
  }

  Future openFile({required String url, String? fileName, context}) async {
    final file = await downloadFile(url, fileName!)
        .whenComplete(() => showSnackBar('download complete', context));
    if (file == null) return;

    OpenFile.open(file.path);
  }

//todo move these function from main file
//todo to be removed later
//download new apk update
  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    try {
      final response = await Dio().get(url, onReceiveProgress: (rcv, total) {
        //todo remove after testing

        setState(() {
          progress = ((rcv / total));
        });
      },
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0));
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }
}
