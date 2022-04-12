import 'package:geolocator/geolocator.dart';

class GeolocatorSerive {
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
