import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:image_crop_widget/image_crop_widget.dart';
import 'package:flutter/material.dart';

Future<ui.Image> loadImageFromUint8List(Uint8List inputImage) async {
  final Completer<ui.Image> completer = Completer<ui.Image>();
  ui.decodeImageFromList(inputImage, completer.complete);
  return completer.future;
}

class CropImage extends StatefulWidget {
  const CropImage({
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

class _CropImageState extends State<CropImage> {
  final GlobalKey<ImageCropState> key = GlobalKey<ImageCropState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<ui.Image>(
          future: loadImageFromUint8List(widget.inputByteImage),
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
