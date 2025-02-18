import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showweatherapp/core/constants/app_constants.dart';
import 'package:showweatherapp/helper/date_and_time_helper.dart';
import 'package:showweatherapp/presentation/controllers/home_view_controller.dart';
import 'package:showweatherapp/presentation/pages/web_view/weather_webview_details.dart';
import 'package:showweatherapp/presentation/widgets/weather_forecast_card.dart';
import 'package:showweatherapp/presentation/widgets/weather_value.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomeView> {
  HomeViewController viewModel = Get.put(HomeViewController());
  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width;
    var sizeHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: sizeHeight,
          width: sizeWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppConstants.appBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => Text(
                                  viewModel.location.value,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  viewModel.changeLocation();
                                },
                                child: Icon(
                                  Icons.location_on_outlined,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                          Obx(
                            () => Text(
                              "${viewModel.weathermodel.value.main?.temp.toString()}°",
                              style: const TextStyle(
                                fontSize: 60,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              viewModel
                                      .weathermodel.value.weather?.first.main ??
                                  "N/A",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            DateAndTimeHelper.getCurrentDate(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                      onTap: () {
                        Get.to(() => WeatherWebviewDetails());
                      },
                      child: Text(
                        "Explore more",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  WeatherValue(),
                  Divider(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WeatherForecastCard(
                                time: "12 AM",
                                weatherIcon: AppConstants.moonCloudFastwind,
                                temperature: "19"),
                            WeatherForecastCard(
                                time: "Now",
                                weatherIcon: AppConstants.tornadoImg,
                                temperature: "19"),
                            WeatherForecastCard(
                                time: "2 AM",
                                weatherIcon: AppConstants.moonCloudMidrain,
                                temperature: "18"),
                            WeatherForecastCard(
                                time: "3 AM",
                                weatherIcon: AppConstants.sunCloudAngledrain,
                                temperature: "19"),
                            WeatherForecastCard(
                                time: "4 AM",
                                weatherIcon: AppConstants.sunCloudMiddrain,
                                temperature: "19"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
