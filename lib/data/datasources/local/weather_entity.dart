import 'package:floor/floor.dart';

@entity
class WeatherEntity {
  @primaryKey
  final String location;
  final String jsonData;
  WeatherEntity({required this.location, required this.jsonData});
}
