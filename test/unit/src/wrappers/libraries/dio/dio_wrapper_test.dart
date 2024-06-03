import 'package:dio/dio.dart';
import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_interceptor.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final dio = _MockDio();
  final dioInterceptor = _MockDioInterception();

  // TODO tested class
  final dioWrapper = DioWrapper(
    interceptor: dioInterceptor,
    dio: dio,
  );

  setUpAll(() {
    when(() => dio.interceptors.add(any())).thenReturn(null);
  });

  tearDown(() {
    reset(dio);
    reset(dioInterceptor);
  });

  // TODO will need to use interceptor test one to actually prevent making requests in tests

  // TODO we could now test that the interceptor is added?

  group(
    "DioWrapper",
    () {
      group(
        ".get()",
        () {
          // should throw expected error when fail get request
          test(
            "given something goes wrong with the request"
            "when .get() is called"
            "then should throw expected exception",
            () async {
              // setup
              const uriParts = HttpRequestUriPartsValue(
                apiUrlScheme: "https",
                apiBaseUrl: "api.example.com",
                apiContextPath: "api",
                apiEndpointPath: "endpoint",
                queryParameters: {},
              );

              // given
              dioWrapper.get(uriParts: uriParts);

              // when

              // then
              expect(3, 3);

              // cleanup
            },
          );
          // fail post request

          // fail delete request

          // fail get with no body data

          // fail post with no body data

          // fail delete with no body data

          // should return expected data when success request

          // should return expected data type when success request

          // should pass expected arghuments to dio.requestUri when called
        },
      );
    },
  );
}

class _MockDio extends Mock implements Dio {}

class _MockDioInterception extends Mock implements DioInterceptor {}
