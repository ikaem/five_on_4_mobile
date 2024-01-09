import 'dart:async';

import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import "package:rxdart/rxdart.dart";

class AuthStatusDataSourceImpl implements AuthStatusDataSource {
  final BehaviorSubject<AuthDataEntity?> _authDataStatusSubject =
      BehaviorSubject<AuthDataEntity?>();

  StreamSink<AuthDataEntity?> get _authDataStatusSink =>
      _authDataStatusSubject.sink;

  @override
  Stream<AuthDataEntity?> get authDataStatusStream =>
      _authDataStatusSubject.stream;

  @override
  AuthDataEntity get authDataStatus {
    throw UnimplementedError();
  }

  @override
  void setAuthDataStatus(AuthDataEntity? authData) {
    _authDataStatusSink.add(authData);
  }

  @override
  Future<void> dispose() async {
    await _authDataStatusSubject.close();
  }
}
