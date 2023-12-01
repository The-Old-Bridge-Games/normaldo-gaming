import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:normaldo_gaming/data/auth/services/auth_local_storage.dart';

class TokenInterceptor implements RequestInterceptor {
  const TokenInterceptor(this._authLocalStorage);

  final AuthLocalStorage _authLocalStorage;
  @override
  FutureOr<Request> onRequest(Request request) async {
    if (request.headers['needAuth'] == 'true') {
      final token = await _authLocalStorage.fetchToken();
      if (token == null) return request;
      return request.copyWith(
          headers: request.headers
            ..[HttpHeaders.authorizationHeader] = 'Bearer $token');
    }
    return request;
  }
}
