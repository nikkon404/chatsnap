import 'dart:io';

import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final File imageFile;

  ImagePreview({@required this.imageFile});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Image.file(imageFile),
        ),
      ),
    );
  }
}
