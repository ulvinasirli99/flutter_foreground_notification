import 'package:background_location/background_location.dart';
import 'package:latlong2/latlong.dart';

class LocationBackground {
  
  static LocationBackground locationBackground = LocationBackground._internal();

  LocationBackground._internal();

  static LocationBackground get instance => locationBackground;

  Future<void> startForegroundSerive() async {
  
    await BackgroundLocation.setAndroidNotification(
  
      title: 'Background service is running',
  
      message: 'Background location in progress',
  
      icon: '@mipmap/ic_launcher',
  
    );
  
    //await BackgroundLocation.setAndroidConfiguration(1000);
    await BackgroundLocation.startLocationService(distanceFilter: 5);
  
    BackgroundLocation.getLocationUpdates((location) {
  
      print("Data : " + location.toMap().toString());
  
    });
  
  }

  Future<LatLng> updateLocationData() async {
  
    await BackgroundLocation.startLocationService();
  
    LatLng location = LatLng(0, 0);
  
    BackgroundLocation.getLocationUpdates((locationP) {
  
      location = LatLng(
  
          locationP.latitude!.toDouble(), locationP.longitude!.toDouble());
  
      print('Bu heqiqi Locationdir : ' + location.toJson().toString());
  
    });
  
    return location;
  
  }

  
  Future<void> getStopBackLocation() async {
  
    await BackgroundLocation.stopLocationService();
  
  }

}
