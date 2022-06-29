import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constant.dart';
import '../screen/expandedImage_screen.dart';
import '../utilityFunctions.dart';

class PhotoGrid extends StatefulWidget {
  final int maxImages;
  final List<String> imageUrls;

  final Function onExpandClicked;

  PhotoGrid({
    required this.imageUrls,
    required this.onExpandClicked,
    this.maxImages = 4,
  });

  @override
  createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  @override
  Widget build(BuildContext context) {
    var images = buildImages();
    int rCCount = widget.imageUrls.length == 1 ? 1 : 2;
    return ClipRRect(
      //round image container border

      borderRadius: BorderRadius.circular(20.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: rCCount,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        children: images,
      ),
    );
  }

  List<Widget> buildImages() {
    int numImages = widget.imageUrls.length;
    return List<Widget>.generate(min(numImages, widget.maxImages), (index) {
      String imageUrl = widget.imageUrls[index];

      // If its the last image
      if (index == widget.maxImages - 1) {
        // Check how many more images are left
        int remaining = numImages - widget.maxImages;

        // If no more are remaining return a simple image widget
        if (remaining == 0) {
          return GestureDetector(
            child: CachedNetworkImage(
              errorWidget: (context, url, error) => (Icon(
                Icons.error_outline_rounded,
                color: Colors.grey,
                size: 30,
              )),
              placeholder: (context, url) => CustomCircularProgressIndicator(),
              imageUrl: imageUrl,
              fit: BoxFit.fill,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return ExpandedImage(
                  imageUrl: imageUrl,
                );
              }));
            },
          );
        } else {
          // Create the facebook like effect for the last image with number of remaining  images
          return GestureDetector(
            onTap: () => widget.onExpandClicked(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  errorWidget: (context, url, error) => (Icon(
                    Icons.error_outline_rounded,
                    color: Colors.grey,
                    size: 30,
                  )),
                  placeholder: (context, url) =>
                      CustomCircularProgressIndicator(),
                  imageUrl: imageUrl,
                  fit: BoxFit.fill,
                ),
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
          child: Hero(
            tag: imageUrl,
            child: CachedNetworkImage(
              errorWidget: (context, url, error) => (Icon(
                Icons.error_outline_rounded,
                color: Colors.grey,
                size: 30,
              )),
              placeholder: (context, url) => CustomCircularProgressIndicator(),
              imageUrl: imageUrl,
              fit: BoxFit.fill,
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ExpandedImage(
                imageUrl: imageUrl,
              );
            }));
          },
        );
      }
    });
  }
}
