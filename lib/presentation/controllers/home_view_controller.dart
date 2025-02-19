import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showweatherapp/data/datasources/local/app_database.dart';
import 'package:showweatherapp/data/datasources/local/weather_entity.dart';
import 'package:showweatherapp/data/models/weather_model.dart';
import 'package:showweatherapp/helper/getx_helper.dart';

import 'package:showweatherapp/presentation/pages/locations/locations_search_view.dart';

class HomeViewController extends GetxController {
  Rx<Weathermodel> weathermodel = Weathermodel().obs;
  RxString location = "Kathmandu, Nepal".obs;
  late AppDatabase database;//database instance to store or retreive data

  @override
  void onInit() async {
    super.onInit();
    await initDatabase();//local database initialize 
    await getLastLocationAndUpdate();//get the last location and update weather data
  }

//local databsae initialize
  Future<void> initDatabase() async {
    database =
        await $FloorAppDatabase.databaseBuilder('weather_database.db').build();
  }

  void changeLocation() async {
    var result = await Get.to(() => LocationsSearchView());//navigate to location search view screen
    if (result != null) {//if the location is selected, update location and save it
      location.value = result;
      await saveLastLocation(location.value);//save the new location to database 
      await getLastLocationAndUpdate();//fetch weather data for the new location
    }
  }

  /// Save last selected location to the database
  Future<void> saveLastLocation(String loc) async {
    print("Saving location: $loc");
    final lastLocEntity =
        WeatherEntity(location: 'lastLocation', jsonData: loc);
    await database.weatherDao.insertWeather(lastLocEntity);
    print(" Location saved successfully!");
  }

//get the last saved location from ther database and update the weather
  Future<void> getLastLocationAndUpdate() async {
    //retrieve weather data from local database
    final lastlocEntity = await database.weatherDao.getWeather('lastLocation');//retrieve saved location
    if (lastlocEntity != null) {
      location.value = lastlocEntity.jsonData;//set location to the saved one 
      print("Retrieved last location: ${location.value}");
    } else {
      location.value = "Kathmandu, Nepal";//use defalut location if no location is saved 
      print("No saved location found. Using default: Kathmandu, Nepal");
    }
    final weatherEntity = await database.weatherDao.getWeather(location.value); //retriev weather data
    if (weatherEntity != null) {
      weathermodel.value =
          Weathermodel.fromJson(jsonDecode(weatherEntity.jsonData));//parse and set weather data
    } else {
      print("No offline weather data found. Fetching from API..");
    }
    await getWeatherUpdate();//fetched the latest weather data from API
  }

  Future<void> getWeatherUpdate() async {
    try {
      // Headers
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      // API URL and parameters
      String url = 'https://api.openweathermap.org/data/2.5/weather';
      Map<String, String> params = {
        'appid': '63fe75528c6a11affd5006023eef9683',
        'q': location.value,
        'units': 'metric',
      };

      //constructing full url with query parameters
      String fullUrl =
          Uri.parse(url).replace(queryParameters: params).toString();

      //calling api using dio packages
      dio.Dio dioInstance = dio.Dio();
      dio.Response<dynamic> response = await dioInstance.get(fullUrl,
          options: dio.Options(headers: headers));

      //Json parsing for api response
      if (response.statusCode == 200) {
        Map<String, dynamic> parsedJson = response.data;

        if (parsedJson['cod'] == 200) {
          weathermodel.value = Weathermodel.fromJson(parsedJson);//update the weather model
          await database.weatherDao.insertWeather(WeatherEntity(
              location: location.value, jsonData: jsonEncode(parsedJson)));//save data to local database
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
      final offlineWeather =
          await database.weatherDao.getWeather(location.value);//retreive offline data
      if (offlineWeather != null) {
        weathermodel.value =
            Weathermodel.fromJson(jsonDecode(offlineWeather.jsonData));//use offline weather data
        GetxHelper.showSnackbar(
            message: "Fetched successfully from local database");
      } else {
        GetxHelper.showSnackbar(message: "No offline data available");
      }
    }
  }
}
