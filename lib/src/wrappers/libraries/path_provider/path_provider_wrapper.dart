import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class PathProviderWrapper {
  const PathProviderWrapper();

  @visibleForTesting
  void setupForTests() {}

  Future<Directory> getTempDirectory() {
    return getTemporaryDirectory();
  }

  Future<Directory> getAppDocumentsDirectory() {
    return getApplicationDocumentsDirectory();
  }
}
