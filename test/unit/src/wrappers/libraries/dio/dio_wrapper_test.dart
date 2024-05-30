import 'package:flutter_test/flutter_test.dart';

void main() {
  // TODO will need to use interceptor test one to actually prevent making requests in tests

  group(
    "DioWrapper",
    () {
      group(
        ".get()",
        () {
          test(
            "given a url"
            "when .get() is called"
            "should return expected response",
            () async {
              // write the
              // TODO we need to write tests
              // TODO how to write tests for this
              // TODO we could pass it mock dio instance, and check that stuff is called
              // TODO this should accept dio inteceptor too
            },
          );
        },
      );
    },
  );
}
