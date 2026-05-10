enum FuelType { petrol, diesel, cng, electric, hybrid }
enum VehicleType { car, bike, scooter, suv, truck, auto }

class Vehicle {
  const Vehicle({
    required this.id,
    required this.type,
    required this.make,
    required this.model,
    required this.plate,
    required this.fuel,
    this.year,
    this.colorHex,
  });

  final String id;
  final VehicleType type;
  final String make;
  final String model;
  final String plate;
  final FuelType fuel;
  final int? year;
  final String? colorHex;

  factory Vehicle.fromJson(Map<String, dynamic> j) => Vehicle(
        id: j['id'] as String,
        type: VehicleType.values.byName(j['type'] as String),
        make: j['make'] as String,
        model: j['model'] as String,
        plate: j['plate'] as String,
        fuel: FuelType.values.byName(j['fuel'] as String),
        year: j['year'] as int?,
        colorHex: j['colorHex'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'make': make,
        'model': model,
        'plate': plate,
        'fuel': fuel.name,
        if (year != null) 'year': year,
        if (colorHex != null) 'colorHex': colorHex,
      };
}
