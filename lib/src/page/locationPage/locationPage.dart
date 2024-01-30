import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String _locationMessage = "";

  @override
  void initState() {
    super.initState();
    // Commenting this out to prevent automatic location retrieval on app startup
    // _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position);

      setState(() {
        _locationMessage =
            "Latitude: ${position.latitude}\nLongitude: ${position.longitude}";
      });
    } catch (e) {
      setState(() {
        _locationMessage = "Error getting location: $e";
      });
    }
  }

  void _getLocation1() {
    setState(() {
      _locationMessage = "Latitude: 0\nLongitude: 0";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Geolocator Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _getLocation();
                },
                child: Text('Get Location'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _getLocation1();
                },
                child: Text('Set Location to (0, 0)'),
              ),
              Text(
                _locationMessage,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
