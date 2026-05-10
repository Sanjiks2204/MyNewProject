import 'package:mechzo_models/mechzo_models.dart';

import 'client.dart';

class JobsApi {
  JobsApi(this._client);
  final MechzoApiClient _client;

  Future<String> createJob({
    required String vehicleId,
    required ProblemCategory category,
    required Address pickup,
    String? description,
    List<String> photoUrls = const [],
  }) async {
    final res = await _client.dio.post('/jobs', data: {
      'vehicleId': vehicleId,
      'category': category.name,
      'pickup': pickup.toJson(),
      if (description != null) 'description': description,
      'photoUrls': photoUrls,
    });
    return res.data['jobId'] as String;
  }

  Future<void> cancelJob(String jobId, {String? reason}) async {
    await _client.dio.post('/jobs/$jobId/cancel', data: {'reason': reason});
  }
}
