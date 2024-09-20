// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class GeofencePage extends StatefulWidget {
  const GeofencePage({super.key});

  @override
  _GeofencePageState createState() => _GeofencePageState();
}

class _GeofencePageState extends State<GeofencePage> {
  final MapController _mapController = MapController();
  final Location _location = Location();
  LatLng? _selectedPosition;
  double _radius = 100.0; // Default radius for the geofence
  List<CircleMarker> _geofenceCircles = [];

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    var currentLocation = await _location.getLocation();
    LatLng currentLatLng = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    _mapController.move(currentLatLng, 14.0); // Move the map to the current location
  }

  void _onMapTap(LatLng position) {
    setState(() {
      _selectedPosition = position;
      _updateGeofenceCircle();
    });
  }

  void _updateGeofenceCircle() {
    if (_selectedPosition != null) {
      _geofenceCircles.add(
        CircleMarker(
          point: _selectedPosition!,
          radius: _radius,
          color: Colors.blue.withOpacity(0.5),
          borderStrokeWidth: 2,
          borderColor: Colors.blue,
        ),
      );
    }
  }

  void _addGeofence() {
    if (_selectedPosition != null) {
      print('Geofence added at $_selectedPosition with radius $_radius meters');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Geofence added successfully!')),
      );
      // Reset selection
      setState(() {
        _selectedPosition = null;
        _radius = 100.0; // Reset to default radius
        _geofenceCircles = _geofenceCircles; // Keep existing geofences
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a position on the map!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add/Alter Geofence'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(37.42796133580664, -122.085749655962), // Default location
              zoom: 14.0,
              onTap: (tapPosition, latLng) => _onMapTap(latLng),
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              CircleLayer(circles: _geofenceCircles),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Geofence Radius: ${_radius.round()} meters'),
                Slider(
                  min: 50,
                  max: 500,
                  value: _radius,
                  onChanged: (newRadius) {
                    setState(() {
                      _radius = newRadius;
                      _updateGeofenceCircle();
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: _addGeofence,
                  child: const Text('Add Geofence'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
