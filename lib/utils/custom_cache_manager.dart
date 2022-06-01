import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {

  static const key = 'dukaan-cache-manager';

  static CacheManager instance = CacheManager(

    Config(
      key,
      stalePeriod: Duration(days: 30),
      maxNrOfCacheObjects: 2500,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileService: HttpFileService(),
    ),
  );


  static Future<File> getImage(String url) async {

    File file = await instance.getSingleFile(url);
    return file;
  }
}