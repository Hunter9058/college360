//images grid view for notes

import 'dart:io';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class NotesImageGridView extends StatefulWidget {
  final int maxImages;
  final List<XFile?> imagePath;
  final Function(int) onImageClicked;
  final Function onExpandClicked;

  NotesImageGridView({
    required this.imagePath,
    required this.onImageClicked,
    required this.onExpandClicked,
    this.maxImages = 4,
  });

  @override
  createState() => _NotesImageGridViewState();
}

class _NotesImageGridViewState extends State<NotesImageGridView> {
  @override
  Widget build(BuildContext context) {
    var images = buildImages();
    print('grid is working');
    return ClipRRect(
      //round image container border
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadius: BorderRadius.circular(20.0),
      child: GridView(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            //width
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            maxCrossAxisExtent: MediaQuery.of(context).size.height * 0.36,
            mainAxisExtent: MediaQuery.of(context).size.width * 0.36),
        children: images,
      ),
    );
  }

  List<Widget> buildImages() {
    int numImages = widget.imagePath.length;
    return List<Widget>.generate(min(numImages, widget.maxImages), (index) {
      XFile? imagePath = widget.imagePath[index];
      File image = File(imagePath!.path);
      //todo remove after testing
      print(image.path);
      // If its the last image
      if (index == widget.maxImages - 1) {
        // Check how many more images are left
        int remaining = numImages - widget.maxImages;

        // If no more are remaining return a simple image widget
        if (remaining == 0) {
          return GestureDetector(
            child: Image.file(
              image,
              fit: BoxFit.cover,
            ),
            onTap: () => widget.onImageClicked(index),
          );
        } else {
          // Create the facebook like effect for the last image with number of remaining  images
          return GestureDetector(
            onTap: () => widget.onExpandClicked(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.file(image, fit: BoxFit.cover),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: Text(
                      '+' + remaining.toString(),
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        return GestureDetector(
          child: Image.file(
            image,
            fit: BoxFit.cover,
          ),
          onTap: () => widget.onImageClicked(index),
        );
      }
    });
  }
}
