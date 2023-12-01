import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/data/auth/services/auth_local_storage.dart';

class AuthInterceptor implements ResponseInterceptor {
  const AuthInterceptor(this._authLocalStorage);

  final AuthLocalStorage _authLocalStorage;

  @override
  FutureOr<Response> onResponse(Response response) {
    if (!response.isSuccessful) {
      if (response.statusCode == HttpStatus.unauthorized) {
        _authLocalStorage.deleteToken();
      }
      throw NetworkException.fromResponse(response);
    }
    return response;
  }
}
