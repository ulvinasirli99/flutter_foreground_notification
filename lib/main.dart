import 'dart:async';

import 'package:background_geolocation/location_back.dart';
import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String latitude = 'waiting...';
  String longitude = 'waiting...';
  String altitude = 'waiting...';
  String accuracy = 'waiting...';
  String bearing = 'waiting...';
  String speed = 'waiting...';
  String time = 'waiting...';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Background Location Service'),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              locationData('Latitude: ' + latitude),
              locationData('Longitude: ' + longitude),
              locationData('Altitude: ' + altitude),
              locationData('Accuracy: ' + accuracy),
              locationData('Bearing: ' + bearing),
              locationData('Speed: ' + speed),
              locationData('Time: ' + time),
              ElevatedButton(
                  onPressed: () async {
                    LocationBackground.instance.startForegroundSerive();
                  },
                  child: Text('Start Location Service')),
              ElevatedButton(
                  onPressed: () {
                    LocationBackground.instance.getStopBackLocation();
                  },
                  child: Text('Stop Location Service')),
              ElevatedButton(
                  onPressed: () async {
                    await BackgroundLocation.startLocationService();
                    Timer.periodic(Duration(seconds: 1), (timer) async {
                      await BackgroundLocation()
                          .getCurrentLocation()
                          .then((value) {
                        print(
                          "Current Location : " + value.toMap().toString(),
                        );
                      });
                    });
                  },
                  child: Text('Get Current Location')),
            ],
          ),
        ),
      ),
    );
  }

  Widget locationData(String data) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    );
  }
}
