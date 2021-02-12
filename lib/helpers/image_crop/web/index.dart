import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:image_crop_widget/image_crop_widget.dart';
import 'package:flutter/material.dart';

Future<ui.Image> _loadImageFromUint8List(Uint8List inputImage) async {
  final Completer<ui.Image> completer = Completer<ui.Image>();
  ui.decodeImageFromList(inputImage, completer.complete);
  return completer.future;
}

Future<Uint8List> _imageToUint8List(ui.Image inputImage) async {
  final ByteData? byteData =
      await inputImage.toByteData(format: ui.ImageByteFormat.png);
  if (byteData != null) {
    return byteData.buffer.asUint8List();
  } else {
    throw ArgumentError('Cannot get ByteData from Image');
  }
}

class _CropImage extends StatefulWidget {
  const _CropImage({
    required this.inputByteImage,
    required this.onPress,
    Key? key,
  }) : super(key: key);
  // final ui.Image imageFile;
  final Uint8List inputByteImage;
  final Function(ui.Image) onPress;
  @override
  _CropImageState createState() => _CropImageState();
}

class _CropImageState extends State<_CropImage> {
  final GlobalKey<ImageCropState> key = GlobalKey<ImageCropState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<ui.Image>(
          future: _loadImageFromUint8List(widget.inputByteImage),
          builder: (
            BuildContext context,
            AsyncSnapshot<ui.Image> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ImageCrop(
                      key: key,
                      image: snapshot.data,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      final ImageCropState? imageState = key.currentState;
                      if (imageState != null) {
                        final ui.Image croppedImage =
                            await imageState.cropImage();
                        await widget.onPress(croppedImage);
                      }
                    },
                    child: const Text('Okay'),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

Future<Uint8List> cropImage(
  Uint8List oldFile, {
  required int maxWidth,
  required int maxHeight,
  required BuildContext context,
  bool jpg = false,
  bool circle = false,
  int compressQuality = 100,
}) async {
  Uint8List cropImage = Uint8List.fromList(<int>[]);
  await Navigator.push(
    context,
    MaterialPageRoute<Widget>(
      builder: (BuildContext context) {
        return _CropImage(
          inputByteImage: oldFile,
          onPress: (ui.Image croppedImage) async {
            cropImage = await _imageToUint8List(croppedImage);
            Navigator.pop(context);
          },
        );
      },
    ),
  );
  return (cropImage == Uint8List.fromList(<int>[])) ? oldFile : cropImage;
}
