import 'package:flutter/services.dart';

Future<void> shareImage(String imagePath) async =>
    throw PlatformException(code: 'Platform Not Supported');

Future<void> shareMultipleImage(List<String> imagePathList) async =>
    throw PlatformException(code: 'Platform Not Supported');
