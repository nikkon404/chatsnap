import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class CamController extends ChangeNotifier {
  CameraController _controller;
  List<CameraDescription> _cameras;

  void setCameraController(CameraDescription description) {
    _controller = CameraController(description, ResolutionPreset.ultraHigh,
        enableAudio: true);
    _controller.initialize().then((_) {
      notifyListeners();
    });
  }

  void init() async {
    _cameras = await availableCameras();
    setCameraController(_cameras.first);
    notifyListeners();
  }

  reverseCam() {
    final lensDirection = _controller.description.lensDirection;
    _cameras.forEach((element) {
      if (element.lensDirection != lensDirection) {
        print('found ' + element.lensDirection.toString());

        setCameraController(element);

        return;
      }
    });
    print(lensDirection);
  }

  CameraController getController() => _controller;

  get allCameras => _cameras;
}
