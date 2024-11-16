import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:projek_skripsi/core/components/map/controllers/maps_controller.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class MapsPage extends StatelessWidget { 
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MapsController());
    return Obx(() => 
      Stack(
        children: [
          FlutterMap(
            mapController: controller.mapController,
            options: MapOptions(
              center: const latlng.LatLng((-6.200000), 106.816666),
              minZoom: 7.0,
              zoom: 7.0,
              onTap: (tapPosition, point) {
                controller.handlePosition(point.latitude, point.longitude);
              },
            ), 
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a','b','c'],
              ),
              controller.longitude.value != 0 && controller.latitude.value != 0 ?
              MarkerLayer(
                markers: [
                  Marker(
                    width: 50.0,
                    height: 50.0,
                    point: latlng.LatLng(controller.latitude.value, controller.longitude.value), 
                    child: IconButton(icon: const Icon(Icons.location_on),
                      onPressed: () => log('marker tapper'))
                  ),
                ]) : const SizedBox(),
            ],
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
              ),
              child: IconButton(
              onPressed: () => controller.getCurrentPosition(),
              color: AppThemes.blue,
              icon: const Icon(Icons.location_on),
            )),
          )
        ],
      ));
  }
}