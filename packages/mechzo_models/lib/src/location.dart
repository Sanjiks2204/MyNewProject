class GeoPoint {
  const GeoPoint({required this.lat, required this.lng});
  final double lat;
  final double lng;

  factory GeoPoint.fromJson(Map<String, dynamic> j) =>
      GeoPoint(lat: (j['lat'] as num).toDouble(), lng: (j['lng'] as num).toDouble());

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};
}

class Address {
  const Address({
    required this.line,
    required this.point,
    this.landmark,
    this.city,
    this.pincode,
  });

  final String line;
  final GeoPoint point;
  final String? landmark;
  final String? city;
  final String? pincode;

  factory Address.fromJson(Map<String, dynamic> j) => Address(
        line: j['line'] as String,
        point: GeoPoint.fromJson(j['point'] as Map<String, dynamic>),
        landmark: j['landmark'] as String?,
        city: j['city'] as String?,
        pincode: j['pincode'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'line': line,
        'point': point.toJson(),
        if (landmark != null) 'landmark': landmark,
        if (city != null) 'city': city,
        if (pincode != null) 'pincode': pincode,
      };
}
