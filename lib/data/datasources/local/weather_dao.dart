import 'package:floor/floor.dart';
import 'package:showweatherapp/data/datasources/local/weather_entity.dart';

@dao
abstract class WeatherDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertWeather(WeatherEntity weather);
  @Query('SELECT * FROM WeatherEntity WHERE location = :location')
  Future<WeatherEntity?> getWeather(String location);
  @Query('SELECT * FROM WeatherEntity')
  Future<List<WeatherEntity>> getAllWeatherData();
}
