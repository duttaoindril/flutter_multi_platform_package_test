import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

Future<Uint8List> getImage({
  bool camera = false,
  bool highQuality = false,
}) async =>
    (await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    ))
        .files
        .first
        .bytes;
