import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // final dioInterceptor = DioInterceptor();

  group(
    "$DioInterceptor",
    () {
      group(
        ".onRequest()",
        () {
          test(
            "given a request"
            "when .onRequest() is called"
            "then should include auth token ",
            () async {
              // write the
              // TODO we need to write tests
            },
          );
        },
      );
    },
  );
}
