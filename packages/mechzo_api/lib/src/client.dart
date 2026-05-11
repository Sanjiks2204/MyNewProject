import 'package:dio/dio.dart';

/// Token providers — apps wire these up to their storage layer.
typedef TokenProvider = Future<String?> Function();
typedef TokenRefresher = Future<String?> Function();

class MechzoApiClient {
  MechzoApiClient({
    required this.baseUrl,
    required this.accessToken,
    required this.refreshAccessToken,
  }) : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'Content-Type': 'application/json'},
        )) {
    _dio.interceptors.add(_AuthInterceptor(accessToken, refreshAccessToken));
  }

  final String baseUrl;
  final TokenProvider accessToken;
  final TokenRefresher refreshAccessToken;
  final Dio _dio;

  Dio get dio => _dio;
}

class _AuthInterceptor extends Interceptor {
  _AuthInterceptor(this._access, this._refresh);
  final TokenProvider _access;
  final TokenRefresher _refresh;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final t = await _access();
    if (t != null) {
      options.headers['Authorization'] = 'Bearer $t';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final fresh = await _refresh();
      if (fresh != null) {
        final req = err.requestOptions;
        req.headers['Authorization'] = 'Bearer $fresh';
        try {
          final res = await Dio().fetch(req);
          return handler.resolve(res);
        } catch (_) {
          // fallthrough
        }
      }
    }
    handler.next(err);
  }
}
