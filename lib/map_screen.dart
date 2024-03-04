import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _currentLocation = LatLng(51.091364, 17.028928); // Default location - Wrocław
  Position? _currentPosition;
  MapController _mapController = MapController();
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation,
              initialZoom: 11.0,
              interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: _markers,
              ),
            ],
          ),
          if (_markers.isNotEmpty)
            Positioned(
              bottom: 16.0,
              left: 16.0,
              child: FloatingActionButton(
                onPressed: _clearMarkers,
                backgroundColor: Colors.red[300],
                child: Icon(Icons.clear),
              ),
            ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                _getCurrentLocation();
                _updateMarkers();
                _mapController.move(_currentLocation, 11.0);
              },
              backgroundColor: Colors.black87,
              child: Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }

  String _getLocationTitle() {
    if (_currentPosition != null) {
      return 'Current Location: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}';
    } else {
      return 'Map';
    }
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await _requestLocationPermission();
    } else {
      await _getCurrentLocation();
    }
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle case when user denies permission
      print('User denied location permission.');
    } else {
      await _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _updateMarkers() {
    // Add a new marker with the current location when the refresh button is pressed
    if (_currentPosition != null) {
      _markers = [
        Marker(
          width: 80.0,
          height: 80.0,
          point: _currentLocation,
          child: Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 40.0,
          ),
        ),
      ];
    }
  }

  void _clearMarkers() {
    setState(() {
      // Clear the markers from the map
      _markers = [];
    });
  }
}


