import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:showweatherapp/presentation/controllers/location_view_controller.dart';

class ListViewItem extends StatelessWidget {
  final int index;
  ListViewItem({super.key, required this.index});
  final LocationViewController locationViewController = Get.put(LocationViewController());

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // ignore: deprecated_member_use
      tileColor: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () {
        locationViewController.onLocationSelection(index);
      },
      leading: Icon(
        Icons.location_on,
        color: Colors.white,
        size: 22,
      ),
      title: Text(
        locationViewController.filterlocationsList[index],
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
