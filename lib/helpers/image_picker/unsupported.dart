import 'dart:typed_data';

import 'package:flutter/services.dart';

Future<Uint8List> getImage({
  bool camera = false,
  bool highQuality = false,
}) async =>
    throw PlatformException(code: 'Platform Not Supported');
