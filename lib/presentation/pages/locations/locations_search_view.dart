import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showweatherapp/core/widgets/custom_search_bar.dart';
import 'package:showweatherapp/presentation/controllers/location_view_controller.dart';
import 'package:showweatherapp/presentation/widgets/list_view_item.dart';

class LocationsSearchView extends StatelessWidget {
  LocationsSearchView({super.key});
  final LocationViewController locationViewController =
      Get.put(LocationViewController());

  @override
  Widget build(BuildContext context) {
    TextEditingController locationController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 102, 123, 133),
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            children: [
              CustomSearchBar(
                controller: locationController,
                onChanged: (value) {
                  locationViewController.onSearchLocation(value);
                },
              ),
              Expanded(
                  child: Obx(() => locationViewController
                          .filterlocationsList.isNotEmpty
                      ? ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 20),
                          itemBuilder: (context, index) {
                            return ListViewItem(
                              index: index,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount:
                              locationViewController.filterlocationsList.length)
                      : Center(
                          child: Text(
                            'No Location Found',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        )))
            ],
          ),
        ),
      ),
    );
  }
}
