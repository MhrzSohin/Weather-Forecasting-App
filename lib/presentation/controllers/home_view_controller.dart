import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:showweatherapp/data/datasources/local/app_database.dart';
import 'package:showweatherapp/data/datasources/local/weather_entity.dart';
import 'package:showweatherapp/data/models/weather_model.dart';
import 'package:showweatherapp/helper/getx_helper.dart';
import 'package:showweatherapp/helper/global_variables.dart';
import 'package:showweatherapp/presentation/pages/locations/locations_search_view.dart';

class HomeViewController extends GetxController {
  Rx<Weathermodel> weathermodel = Weathermodel().obs;
  RxString location = "Kathmandu, Nepal".obs;
  late AppDatabase database;

  @override
  void onInit() async {
    super.onInit();
    await initDatabase();
    await getLastLocationAndUpdate();

    getLastLocationAndUpdate();
  }

  Future<void> initDatabase() async {
    database =
        await $FloorAppDatabase.databaseBuilder('weather_database.db').build();
  }

  void changeLocation() async {
    var result = await Get.to(() => LocationsSearchView());
    if (result != null) {
      location.value = result;
      await saveLastLocation(location.value);
      await getLastLocationAndUpdate();
    }
  }

  /// Save last selected location
  Future<void> saveLastLocation(String loc) async {
    print("Saving location: $loc");
    final lastLocEntity =
        WeatherEntity(location: 'lastLocation', jsonData: loc);
    await database.weatherDao.insertWeather(lastLocEntity);
    print(" Location saved successfully!");
  }

  Future<void> getLastLocationAndUpdate() async {
    //retrieve weather data from local database
    final lastlocEntity = await database.weatherDao.getWeather('lastLocation');
    if (lastlocEntity != null) {
      location.value = lastlocEntity.jsonData;
      print("Retrieved last location: ${location.value}");
    } else {
      location.value = "Kathmandu, Nepal";
      print("No saved location found. Using default: Kathmandu, Nepal");
    }
    final weatherEntity = await database.weatherDao.getWeather(location.value);
    if (weatherEntity != null) {
      weathermodel.value =
          Weathermodel.fromJson(jsonDecode(weatherEntity.jsonData));
    } else {
      print("No offline weather data found. Fetching from API..");
    }
    await getWeatherUpdate();
  }

  Future<void> getWeatherUpdate() async {
    try {
      // Headers
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      // Base URL and parameters
      String url = 'https://api.openweathermap.org/data/2.5/weather';
      Map<String, String> params = {
        'appid': '63fe75528c6a11affd5006023eef9683',
        'q': location.value,
        'units': 'metric',
      };

      //constructing url
      String fullUrl =
          Uri.parse(url).replace(queryParameters: params).toString();

      //show loader
      GlobalVariables.showLoader.value = true;

      //calling api using dio packages
      dio.Dio dioInstance = dio.Dio();
      dio.Response<dynamic> response = await dioInstance.get(fullUrl,
          options: dio.Options(headers: headers));

      //hiding loader after api call
      GlobalVariables.showLoader.value = false;

      //Json parsing
      if (response.statusCode == 200) {
        Map<String, dynamic> parsedJson = response.data;

        if (parsedJson['cod'] == 200) {
          weathermodel.value = Weathermodel.fromJson(parsedJson);
          await database.weatherDao.insertWeather(WeatherEntity(
              location: location.value, jsonData: jsonEncode(parsedJson)));
          // GetStorage().write(location.value, parsedJson);
          GetxHelper.showSnackbar(message: "Weather updated successfully");
        } else {
          GetxHelper.showSnackbar(message: "Something went wrong");
        }
      } else {
        GetxHelper.showSnackbar(
            message:
                "API Error: ${response.statusCode} - ${response.statusMessage}");
      }
    } catch (e) {
      GlobalVariables.showLoader.value = false;
      final offlineWeather =
          await database.weatherDao.getWeather(location.value);
      if (offlineWeather != null) {
        weathermodel.value =
            Weathermodel.fromJson(jsonDecode(offlineWeather.jsonData));
        GetxHelper.showSnackbar(
            message: "Fetched successfully from local database");
      } else {
        GetxHelper.showSnackbar(message: "No offline data available");
      }
    }
  }
}
