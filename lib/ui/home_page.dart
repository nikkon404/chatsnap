import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:chat_snap/provider/cam_controller.dart';
import 'package:chat_snap/ui/cam_page.dart';
import 'package:chat_snap/ui/chat_page.dart';
import 'package:chat_snap/ui/discover_page.dart';
import 'package:chat_snap/ui/widgets/image_preview.dart';
import 'package:chat_snap/ui/widgets/video_preview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  int camPage = 0, chatPage = 1, discoverPage = 2;
  int page = 0;

  bool _buttonPressed = false;
  bool _loopActive = false;
  //CameraController controller;
  List<CameraDescription> cameras;
  String videoPath = '';
  String tempPath = '';

  @override
  void initState() {
    super.initState();
    // initcam();
    getTemporaryDirectory().then((value) {
      tempPath = value.path;
    });
  }

  // initcam() async {
  //   cameras = await availableCameras();
  //   assignCamera(cameras.first);
  // }

  // assignCamera(CameraDescription description) {
  //   setState(() {
  //     controller = CameraController(description, ResolutionPreset.max,
  //         enableAudio: true);
  //     controller.initialize().then((_) {
  //       if (!mounted) {
  //         return;
  //       }
  //     });
  //   });
  // }

  void _increaseCounterWhilePressed() async {
    // make sure that only one loop is active
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed && _counter < 100) {
      // do your thing
      setState(() {
        _counter++;
        // print(_counter.toString());
      });

      // wait a bit
      await Future.delayed(Duration(milliseconds: 40));
    }

    _loopActive = false;
  }

  @override
  Widget build(BuildContext context) {
    final CamController camController = Provider.of<CamController>(context);
    print('x');
    Widget getActiveView() {
      if (page == 0)
        return CamPage();
      else if (page == 1)
        return Chat();
      else if (page == 2) return Discover();
      return SizedBox();
    }

    takePicture() async {
      try {
        final path = join(tempPath, 'snap_cam_${DateTime.now()}.jpg');

        await camController.getController().takePicture(path); //take photo
        print('Image taken and saved to ' + path);
        var imgFile = File(path);

        var res = await Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ImagePreview(
            imageFile: imgFile,
          );
        }));

        if (res == null) {
          print('deleting ' + path);
          imgFile.deleteSync();
        }
      } catch (e) {
        print(e);
      }
    }

    takeVideo() async {
      print('taking video');
      try {
        camController
            .getController()
            .prepareForVideoRecording()
            .then((_) async {
          final path = join(
            tempPath, //Temporary path
            'snap_cam_${DateTime.now()}.mp4',
          );
          setState(() {
            videoPath = path;
            print("video path: " + path);
          });

          camController
              .getController()
              .startVideoRecording(path)
              .then((value) {});
        });
      } catch (e) {
        print('error while taking video');
      }
    }

    Positioned discoverButton() {
      return Positioned(
        child: GestureDetector(
          onTap: () {
            setState(() {
              page = discoverPage;
            });
          },
          child: Column(
            children: <Widget>[
              Icon(
                Icons.dashboard,
                color: Colors.white,
                size: 36,
              ),
              Text('Discover',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ))
            ],
          ),
        ),
        bottom: 30,
        right: 30,
      );
    }

    Positioned chatButton() {
      return Positioned(
        child: GestureDetector(
          onTap: () {
            setState(() {
              page = chatPage;
            });
          },
          child: Column(
            children: <Widget>[
              Icon(
                Icons.chat_bubble,
                color: Colors.white,
                size: 36,
              ),
              Text('Chat',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ))
            ],
          ),
        ),
        bottom: 30,
        left: 30,
      );
    }

    stopRecording() async {
      if (!camController.getController().value.isRecordingVideo) return;
      setState(() {
        _counter = 0;
        _buttonPressed = false;
      });
      await camController.getController().stopVideoRecording();
      print('recording stopped');
      var res = await Navigator.push(context, MaterialPageRoute(builder: (_) {
        return VideoPreview(videoFile: File(videoPath));
      }));
      if (res == null) {
        File(videoPath).delete();
      }
    }

    Container cameraButton() {
      return Container(
        width: 72.0,
        height: 72.0,
        child: FloatingActionButton(
          child: Listener(
            onPointerDown: (_counter >= 100)
                ? (_) {
                    stopRecording();
                  }
                : (details) {
                    if (page == camPage) {
                      _buttonPressed = true;

                      Future.delayed(Duration(milliseconds: 200), () {
                        if (_buttonPressed) {
                          if (!camController
                              .getController()
                              .value
                              .isRecordingVideo) {
                            _increaseCounterWhilePressed();

                            takeVideo();
                          }
                        } else {
                          takePicture();
                        }
                      });
                    } else {
                      print('Not cam page');
                    }
                  },
            onPointerUp: (details) async {
              _buttonPressed = false;
              print('released');

              if (camController.getController().value.isRecordingVideo) {
                await stopRecording();
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: _counter / 100,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    strokeWidth: 8,
                  ),
                ),
                if (_buttonPressed)
                  Icon(
                    Icons.fiber_manual_record,
                    color: Colors.red,
                    size: 35,
                  ),
              ],
            ),
          ),
          onPressed: () {
            setState(() {
              page = camPage;
            });
          },
          backgroundColor: Colors.white,
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: cameraButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(
          children: <Widget>[
            getActiveView(),
            chatButton(),
            discoverButton(),
          ],
        ),
      ),
    );
  }
}
