import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:path_provider/path_provider.dart';

class PathProviderWrapper {
  const PathProviderWrapper();

  @visibleForTesting
  void setupForTests() {
    // TODO implement this
    throw UnimplementedError();
  }

  // Future<Directory> getTempDirectory() {
  //   return getTemporaryDirectory();
  // }

  Future<Directory> getAppDocumentsDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir;
    // return Directory.systemTemp;
  }
}
