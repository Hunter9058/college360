import 'package:flutter/material.dart';

class ExpandedImage extends StatefulWidget {
  final String imageUrl;
  ExpandedImage({required this.imageUrl});

  @override
  State<ExpandedImage> createState() => _ExpandedImageState();
}

class _ExpandedImageState extends State<ExpandedImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child:
              Hero(tag: widget.imageUrl, child: Image.network(widget.imageUrl)),
        ),
      ),
    );
  }
}
