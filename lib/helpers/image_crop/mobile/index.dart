import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

Future<Uint8List> cropImage(
  Uint8List oldFile, {
  required BuildContext context,
  required int maxWidth,
  required int maxHeight,
  bool jpg = false,
  bool circle = false,
  int compressQuality = 100,
}) async {
  if (oldFile == null) {
    return oldFile;
  }
  // if (fileTypeFromFile(oldFile) == '.gif') {
  //   return oldFile;
  // }
  final Uint8List newFile = await (await ImageCropper.cropImage(
    maxWidth: maxWidth,
    maxHeight: maxHeight,
    sourcePath: File.fromRawPath(oldFile).path,
    compressQuality: compressQuality,
    cropStyle: circle ? CropStyle.circle : CropStyle.rectangle,
    compressFormat: jpg ? ImageCompressFormat.jpg : ImageCompressFormat.png,
    aspectRatio: circle ? const CropAspectRatio(ratioX: 1, ratioY: 1) : null,
    aspectRatioPresets: circle
        ? <CropAspectRatioPreset>[
            CropAspectRatioPreset.square,
          ]
        : <CropAspectRatioPreset>[
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
    iosUiSettings: const IOSUiSettings(
        // aspectRatioLockDimensionSwapEnabled: ,
        // aspectRatioLockEnabled: ,
        // aspectRatioPickerButtonHidden: ,
        // cancelButtonTitle: ,
        // doneButtonTitle: ,
        // hidesNavigationBar: ,
        // minimumAspectRatio: ,
        // rectHeight: ,
        // rectWidth: ,
        // rectX: ,
        // rectY: ,
        // resetAspectRatioEnabled: ,
        // resetButtonHidden: ,
        // rotateButtonsHidden: ,
        // rotateClockwiseButtonHidden: ,
        // showActivitySheetOnDone: ,
        // showCancelConfirmationDialog: ,
        // title: ,
        ),
    androidUiSettings: const AndroidUiSettings(
        // activeControlsWidgetColor: ,
        // activeWidgetColor: ,
        // backgroundColor: ,
        // cropFrameColor: ,
        // cropFrameStrokeWidth: ,
        // cropGridColor: ,
        // cropGridColumnCount: ,
        // cropGridRowCount: ,
        // cropGridStrokeWidth: ,
        // dimmedLayerColor: ,
        // hideBottomControls: ,
        // initAspectRatio: ,
        // lockAspectRatio: ,
        // showCropGrid: ,
        // statusBarColor: ,
        // toolbarColor: ,
        // toolbarTitle: ,
        // toolbarWidgetColor: ,
        ),
  ))
      .readAsBytes();
  return newFile ?? oldFile;
}
