import 'package:geolocator/geolocator.dart';

class Location {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  double latitude;
  double longitude;
  String cityName;
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          latitude, longitude);
      Placemark place = p[0];
      cityName=place.locality;
    } catch (e) {
      print(e);
    }
  }
}