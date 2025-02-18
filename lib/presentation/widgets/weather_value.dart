import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showweatherapp/helper/date_and_time_helper.dart';
import 'package:showweatherapp/presentation/controllers/home_view_controller.dart';
import 'package:showweatherapp/presentation/widgets/weather_detail_item.dart';

class WeatherValue extends StatelessWidget {
  const WeatherValue({super.key});

  @override
  Widget build(BuildContext context) {
    HomeViewController homeViewController = Get.put(HomeViewController());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => WeatherDetailItem(
                  title: "Minimum",
                  value:
                      '${homeViewController.weathermodel.value.main?.tempMin ?? 'N/A'}',
                  icon: CupertinoIcons.down_arrow,
                  unit: ' '),
            ),
            SizedBox(
              width: 10,
            ),
            Obx(
              () => WeatherDetailItem(
                  title: 'Maximum',
                  value:
                      '${homeViewController.weathermodel.value.main?.tempMax ?? 'N/A'}',
                  icon: CupertinoIcons.up_arrow,
                  unit: ' '),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => WeatherDetailItem(
                  title: "Wind",
                  value:
                      '${homeViewController.weathermodel.value.wind?.speed ?? 'N/A'}',
                  icon: Icons.wind_power,
                  unit: 'm/s'),
            ),
            SizedBox(
              width: 10,
            ),
            Obx(
              () => WeatherDetailItem(
                  title: 'Feel Like',
                  value:
                      '${homeViewController.weathermodel.value.main?.feelsLike ?? 'N/A'}',
                  icon: Icons.cloudy_snowing,
                  unit: ' '),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => WeatherDetailItem(
                  title: "Pressure",
                  value:
                      '${homeViewController.weathermodel.value.main?.pressure ?? 'N/A'}',
                  icon: Icons.thermostat,
                  unit: 'mbar'),
            ),
            SizedBox(
              width: 10,
            ),
            Obx(
              () => WeatherDetailItem(
                  title: 'Humidity',
                  value:
                      '${homeViewController.weathermodel.value.main?.humidity ?? 'N/A'}',
                  icon: Icons.water_drop_rounded,
                  unit: '%'),
            ),
          ],
        ),
        Divider(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => WeatherDetailItem(
                  title: "Sun Rise",
                  value: DateAndTimeHelper.covertTimeStampToTime(
                      homeViewController.weathermodel.value.sys?.sunrise),
                  icon: Icons.sunny,
                  unit: ' '),
            ),
            SizedBox(
              width: 10,
            ),
            Obx(
              () => WeatherDetailItem(
                  title: 'Sun set',
                  value: DateAndTimeHelper.covertTimeStampToTime(
                      homeViewController.weathermodel.value.sys?.sunset),
                  icon: Icons.sunny_snowing,
                  unit: ' '),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => WeatherDetailItem(
                  title: "Latitude",
                  value:
                      '${homeViewController.weathermodel.value.coord?.lat ?? 'N/A'}',
                  icon: Icons.location_on,
                  unit: ' '),
            ),
            SizedBox(
              width: 10,
            ),
            Obx(
              () => WeatherDetailItem(
                  title: 'Longitude',
                  value:
                      '${homeViewController.weathermodel.value.coord?.lon ?? 'N/A'}',
                  icon: Icons.location_on,
                  unit: ' '),
            ),
          ],
        ),
      ],
    );
  }
}
