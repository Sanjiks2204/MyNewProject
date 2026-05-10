enum ProviderKind { garage, vira }

class Provider {
  const Provider({
    required this.id,
    required this.kind,
    required this.name,
    required this.rating,
    required this.completedJobs,
    this.avatarUrl,
    this.verifiedAt,
  });

  final String id;
  final ProviderKind kind;
  final String name;
  final double rating;
  final int completedJobs;
  final String? avatarUrl;
  final DateTime? verifiedAt;

  factory Provider.fromJson(Map<String, dynamic> j) => Provider(
        id: j['id'] as String,
        kind: ProviderKind.values.byName(j['kind'] as String),
        name: j['name'] as String,
        rating: (j['rating'] as num).toDouble(),
        completedJobs: j['completedJobs'] as int,
        avatarUrl: j['avatarUrl'] as String?,
        verifiedAt: j['verifiedAt'] != null
            ? DateTime.parse(j['verifiedAt'] as String)
            : null,
      );
}
