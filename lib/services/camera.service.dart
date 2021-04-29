import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class CameraService {
  // singleton boilerplate
  static final CameraService _cameraServiceService = CameraService._internal();

  factory CameraService() {
    return _cameraServiceService;
  }
  // singleton boilerplate
  CameraService._internal();

  CameraController _cameraController;
  CameraController get cameraController => this._cameraController;

  CameraDescription _cameraDescription;

  ImageRotation _cameraRotation;
  ImageRotation get cameraRotation => this._cameraRotation;

  String _imagePath;
  String get imagePath => this._imagePath;

  Future startService(CameraDescription cameraDescription) async {
    this._cameraDescription = cameraDescription;
    this._cameraController = CameraController(
      this._cameraDescription,
      ResolutionPreset.high,
      enableAudio: false,
    );

    // sets the rotation of the image
    this._cameraRotation = rotationIntToImageRotation(
      this._cameraDescription.sensorOrientation,
    );

    // Next, initialize the controller. This returns a Future.
    return this._cameraController.initialize();
  }

  ImageRotation rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 90:
        return ImageRotation.rotation90;
      case 180:
        return ImageRotation.rotation180;
      case 270:
        return ImageRotation.rotation270;
      default:
        return ImageRotation.rotation0;
    }
  }

  /// takes the picture and saves it in the given path 📸
  Future<XFile> takePicture() async {
    XFile file = await _cameraController.takePicture();
    this._imagePath = file.path;
    return file;
  }

  /// returns the image size 📏
  Size getImageSize() {
    return Size(
      _cameraController.value.previewSize.height,
      _cameraController.value.previewSize.width,
    );
  }

  dispose() {
    this._cameraController.dispose();
  }
}
