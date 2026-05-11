import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Current user's display name. Null when not yet set (anonymous / pre-onboarding).
/// In a real build this is hydrated from the API after OTP verify + persisted
/// in flutter_secure_storage; for now it's session-only state.
final userNameProvider = StateProvider<String?>((_) => null);

/// Returns a time-appropriate greeting based on the device clock.
String greetingForNow([DateTime? now]) {
  final hour = (now ?? DateTime.now()).hour;
  if (hour >= 5 && hour < 12) return 'Good morning';
  if (hour >= 12 && hour < 17) return 'Good afternoon';
  if (hour >= 17 && hour < 21) return 'Good evening';
  return 'Good night';
}
