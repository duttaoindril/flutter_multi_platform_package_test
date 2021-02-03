import 'package:share_extend/share_extend.dart';

Future<void> shareImage(String imagePath) async {
  await ShareExtend.share(
    imagePath,
    'image',
  );
}

Future<void> shareMultipleImage(List<String> imagePathList) async {
  await ShareExtend.shareMultiple(
    imagePathList,
    'image',
  );
}
