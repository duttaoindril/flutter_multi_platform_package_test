import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> cameraPermissionCheck({
  required BuildContext context,
}) async =>
    throw PlatformException(code: 'Platform Not Supported');

Future<void> photoLibraryPermissionCheck({
  required BuildContext context,
}) async =>
    throw PlatformException(code: 'Platform Not Supported');

Future<void> notificationPermissionCheck({
  required BuildContext context,
}) async =>
    throw PlatformException(code: 'Platform Not Supported');

Future<void> requestPermissionDialog({
  required BuildContext context,
  required String requestType,
}) async =>
    throw PlatformException(code: 'Platform Not Supported');
