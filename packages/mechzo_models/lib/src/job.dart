import 'location.dart';
import 'provider.dart';

enum JobStatus {
  draft,
  created,
  matching,
  matched,
  enRoute,
  onSite,
  inProgress,
  completed,
  cancelled,
  failed,
}

enum ProblemCategory {
  flatTire,
  batteryDead,
  fuelEmpty,
  engineNoise,
  overheating,
  brakes,
  electrical,
  accident,
  keyLockedIn,
  other,
}

class Job {
  const Job({
    required this.id,
    required this.customerId,
    required this.vehicleId,
    required this.category,
    required this.status,
    required this.pickup,
    required this.createdAt,
    this.description,
    this.photoUrls = const [],
    this.provider,
    this.etaMinutes,
    this.priceEstimate,
    this.priceFinal,
  });

  final String id;
  final String customerId;
  final String vehicleId;
  final ProblemCategory category;
  final JobStatus status;
  final Address pickup;
  final DateTime createdAt;
  final String? description;
  final List<String> photoUrls;
  final Provider? provider;
  final int? etaMinutes;
  final int? priceEstimate;
  final int? priceFinal;
}
