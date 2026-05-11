import 'client.dart';

class AuthApi {
  AuthApi(this._client);
  final MechzoApiClient _client;

  /// Request OTP for the given phone number.
  Future<OtpRequestResult> requestOtp(String phone) async {
    final res = await _client.dio.post('/auth/otp/request', data: {'phone': phone});
    return OtpRequestResult(
      requestId: res.data['requestId'] as String,
      resendInSeconds: res.data['resendInSeconds'] as int,
    );
  }

  /// Verify OTP and receive tokens.
  Future<AuthTokens> verifyOtp({
    required String requestId,
    required String code,
  }) async {
    final res = await _client.dio.post('/auth/otp/verify', data: {
      'requestId': requestId,
      'code': code,
    });
    return AuthTokens(
      accessToken: res.data['accessToken'] as String,
      refreshToken: res.data['refreshToken'] as String,
      isNewUser: res.data['isNewUser'] as bool,
    );
  }

  Future<void> logout() => _client.dio.post('/auth/logout');
}

class OtpRequestResult {
  OtpRequestResult({required this.requestId, required this.resendInSeconds});
  final String requestId;
  final int resendInSeconds;
}

class AuthTokens {
  AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    required this.isNewUser,
  });
  final String accessToken;
  final String refreshToken;
  final bool isNewUser;
}
