import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<Uint8List> cropImage(
  Uint8List oldFile, {
  required int maxWidth,
  required int maxHeight,
  required BuildContext context,
  bool jpg = false,
  bool circle = false,
  int compressQuality = 100,
}) async =>
    throw PlatformException(code: 'Platform Not Supported');
