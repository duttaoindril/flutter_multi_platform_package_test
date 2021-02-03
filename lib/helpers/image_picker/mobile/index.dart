import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Future<Uint8List> getImage({
  bool camera = false,
  bool highQuality = false,
}) async =>
    (await ImagePicker().getImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: highQuality ? 100 : null,
      preferredCameraDevice: CameraDevice.rear,
    ))
        .readAsBytes();
