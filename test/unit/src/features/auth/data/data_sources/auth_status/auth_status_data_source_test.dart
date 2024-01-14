import 'dart:async';

import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../../utils/data/entities.dart';

void main() {
  group(
    "AuthStatusDataSource",
    () {
      group(
        ".authDataStatusStream",
        () {
          test(
            "given non-null [AuthDataEntity] value is set "
            "when subscribe to '.authDataStatusStream'"
            "should yield non-null [AuthDataEntity] value",
            () async {
              final authStatusDataSource = AuthStatusDataSourceImpl();
              final testValue = testAuthDataEntity;

              AuthDataEntity? setValue;
              StreamSubscription<AuthDataEntity?>? subscription;

              addTearDown(() {
                authStatusDataSource.dispose();
                subscription?.cancel();
              });

              // set subscription
              subscription =
                  authStatusDataSource.authDataStatusStream.listen((event) {
                setValue = event;
              });

              authStatusDataSource.setAuthDataStatus(testValue);

              // TODO wait for subscription to process its data
              await Future.delayed(Duration.zero);

              expect(setValue, isNotNull);
            },
          );
          test(
            "given null [AuthDataEntity] value is set "
            "when subscribe to '.authDataStatusStream'"
            "should yield null [AuthDataEntity] value",
            () async {
              final authStatusDataSource = AuthStatusDataSourceImpl();
              final testValue = testAuthDataEntity;

              AuthDataEntity? setValue;
              StreamSubscription<AuthDataEntity?>? subscription;

              addTearDown(() {
                authStatusDataSource.dispose();
                subscription?.cancel();
              });

              authStatusDataSource.setAuthDataStatus(testValue);
              // set subscription
              subscription =
                  authStatusDataSource.authDataStatusStream.listen((event) {
                setValue = event;
              });

              authStatusDataSource.setAuthDataStatus(null);

              // TODO wait for subscription to process its data
              await Future.delayed(Duration.zero);

              expect(setValue, isNull);
            },
          );
        },
      );
    },
  );
}
