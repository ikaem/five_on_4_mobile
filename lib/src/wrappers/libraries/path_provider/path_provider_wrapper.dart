import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PathProviderWrapper {
  const PathProviderWrapper();

  Future<Directory> getTempDirectory() {
    return getTemporaryDirectory();
  }

  Future<Directory> getAppDocumentsDirectory() {
    return getApplicationDocumentsDirectory();
  }
}
