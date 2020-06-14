import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_snap/provider/cam_controller.dart';

class CamPage extends StatefulWidget {
  @override
  _CamPageState createState() => _CamPageState();
}

class _CamPageState extends State<CamPage> {
  @override
  Widget build(BuildContext context) {
    final CamController camController = Provider.of<CamController>(context);

    var size = MediaQuery.of(context).size;
    if (camController.getController() != null) {
      if (!camController.getController().value.isInitialized) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
                width: size.width,
                height: size.height,
                child: GestureDetector(
                    onDoubleTap: () => camController.reverseCam(),
                    child: CameraPreview(camController.getController()))),
            Positioned(
                right: 20,
                child: IconButton(
                    icon: Icon(Icons.switch_camera, color: Colors.white),
                    onPressed: () {
                      camController.reverseCam();
                    }))
          ],
        ),
      );
    } else
      return Scaffold(
        backgroundColor: Colors.white,
      );
  }
}
