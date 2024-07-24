final class Coords {
  final double? lat;
  final double? lon;

  const Coords({
    required this.lat,
    required this.lon,
  });

  factory Coords.fromJson(List<dynamic> json) {
    return Coords(
      lat: json[0]["lat"],
      lon: json[0]["lon"],
    );
  }
}
