import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:projek_skripsi/core/components/dialog_component.dart';


class MapsController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var address = ''.obs;

  var mapController = MapController();

  Future<bool> onLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('Layanan lokasi dinonaktifkan. Harap aktifkan layanan')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {   
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(content: Text('Layanan Lokasi ditolak')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('Izin lokasi ditolak secara permanen, kami tidak dapat meminta izin.')));
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await onLocationPermission();
    if (!hasPermission) return;
    DialogComponent().onLoadingDismissible();
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then((Position position) async {
        await handlePosition(position.latitude, position.longitude);
        Get.isDialogOpen != null && Get.isDialogOpen! == true ? Get.back() : null;
      }).catchError((e) {
        Get.isDialogOpen != null && Get.isDialogOpen! == true ? Get.back() : null;
        log(e);
      });
  }

  Future<void> getAddressFromLatLng() async {
    await placemarkFromCoordinates(latitude.value, longitude.value)
      .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        address.value = '${place.street}, ${place.subLocality} ${place.subAdministrativeArea}, ${place.postalCode}';
      }).catchError((e) {
        log(e);
      });
  }

  Future<void> handlePosition(double lat, double long) async {
    latitude.value = lat;
    longitude.value = long;
    mapController.move(latlng.LatLng(lat, long),18);
    await getAddressFromLatLng();
  }
}