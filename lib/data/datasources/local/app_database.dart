import 'dart:async';
import 'package:floor/floor.dart';
import 'weather_entity.dart';
import 'weather_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [WeatherEntity])
abstract class AppDatabase extends FloorDatabase {
  WeatherDao get weatherDao;
}
