import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> cameraPermissionCheck({
  required BuildContext context,
}) async {
  if (Platform.isIOS) {
    if (!(await Permission.camera.request().isGranted)) {
      await requestPermissionDialog(
        context: context,
        requestType: 'use the Camera',
      );
    }
  }
}

Future<void> photoLibraryPermissionCheck({
  required BuildContext context,
}) async {
  if (Platform.isIOS) {
    if (!(await Permission.photos.request().isGranted)) {
      await requestPermissionDialog(
        context: context,
        requestType: 'access the Photo Library',
      );
    }
  }
}

Future<void> notificationPermissionCheck({
  required BuildContext context,
}) async {
  if (!(await Permission.notification.request().isGranted)) {
    await requestPermissionDialog(
      context: context,
      requestType: 'use Notifications',
    );
  }
}

Future<void> requestPermissionDialog({
  required BuildContext context,
  required String requestType,
}) async {
  // await popInfoDialog(
  //   backgroundColor: SpotlytColors.primary800,
  //   context: context,
  //   title: Align(
  //     alignment: Alignment.center,
  //     child: Text(
  //       'Permission Request',
  //       style: Theme.of(context).textTheme.headline2,
  //     ),
  //   ),
  //   content: Flex(
  //     mainAxisSize: MainAxisSize.min,
  //     direction: Axis.vertical,
  //     children: <Flex>[
  //       Column(
  //         children: <Widget>[
  //           Text.rich(
  //             TextSpan(children: <TextSpan>[
  //               const TextSpan(
  //                 text: 'To do this, the app must ',
  //                 style: TextStyle(
  //                   fontFamily: 'ProximaNova',
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //               TextSpan(
  //                 text: requestType,
  //                 style: const TextStyle(
  //                   fontFamily: 'ProximaNova',
  //                   fontWeight: FontWeight.w700,
  //                 ),
  //               ),
  //               const TextSpan(
  //                 text: '. Please grant ',
  //                 style: TextStyle(
  //                   fontFamily: 'ProximaNova',
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //               const TextSpan(
  //                 text: 'Spotlyt ',
  //                 style: TextStyle(
  //                   fontFamily: 'ProximaNova',
  //                   fontWeight: FontWeight.w700,
  //                 ),
  //               ),
  //               const TextSpan(
  //                 text: 'access to continue.',
  //                 style: TextStyle(
  //                   fontFamily: 'ProximaNova',
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //             ]),
  //           ),
  //           const SizedBox(height: 30),
  //           SlideFadeIn(
  //             child: FlatButton(
  //               color: SpotlytColors.secondary600,
  //               onPressed: () async {
  //                 await openAppSettings();
  //               },
  //               autofocus: true,
  //               padding: const EdgeInsets.symmetric(horizontal: 10),
  //               child: Text(
  //                 'Go to Device Settings',
  //                 style: Theme.of(context).textTheme.subtitle2,
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ],
  //   ),
  //   closeText: 'Go back',
  // );
}
