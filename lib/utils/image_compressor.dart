import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageCompressor {

  static Future<File> compress(File file, int quality) async {

    final filePath = file.absolute.path;

    final lastIndex = filePath.lastIndexOf(".");
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${".jpg"}";

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, outPath,
      quality: quality,
    );

    return result;
  }
}