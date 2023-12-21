import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_studio_gallery/menu/tampilan_utama.dart';
import 'package:mobile_studio_gallery/pesanan/tampilan_pesanan_new.dart';
import 'package:mobile_studio_gallery/user/data_pribadi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyMap());

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  State createState() => _MyAppState();
}

class _MyAppState extends State<MyMap> {
  late GoogleMapController mapController;

  Set<Marker> _markers = {}; // Use a variable instead of a final set
  Set<Polyline> _routePolylines = {};
  Map<String, double> _studioDistances = {};

  final LatLng _sumiSpaceLocation = const LatLng(1.146863, 104.008261);
  final LatLng _anteresStudioLocation = const LatLng(1.042050, 103.985441);
  final LatLng _polibatamLocation = const LatLng(1.118658, 104.048497);

  int _currentIndex = 0; // Current index of the BottomNavigationBar

  @override
  void initState() {
    super.initState();
    _updateMarkers();
  }

  // Method to fetch directions using Google Maps Directions API
  Future<void> _fetchDirections(LatLng origin, LatLng destination) async {
    final apiKey = 'YOUR_API_KEY_HERE'; // Replace with your API key
    final apiUrl =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final List<LatLng> points =
            _decodePolyline(data['routes'][0]['overview_polyline']['points']);
        print('Polyline points: $points');

        setState(() {
          Polyline polyline = Polyline(
            polylineId: PolylineId(destination.toString()),
            points: points,
            color: Colors.blue,
            width: 5,
          );
          _routePolylines.add(polyline);
          double distance = _calculateDistance(points);
          _studioDistances[destination.toString()] = distance;
        });
      }
    } else {
      throw Exception('Failed to fetch directions');
    }
  }

// Method to decode polyline points
  List<LatLng> _decodePolyline(String encoded) {
    final List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      lat += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      lng += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      points.add(LatLng(lat / 1e5, lng / 1e5));
    }

    return points;
  }

  double calculateDistanceToSumispace() {
    LatLng sumispaceLocation = LatLng(-6.356273, 106.843412);
    double distance = _coordinateDistance(
      _polibatamLocation.latitude,
      _polibatamLocation.longitude,
      sumispaceLocation.latitude,
      sumispaceLocation.longitude,
    );
    return distance;
  }

  // Method to add route markers and fetch directions when the map is created
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('Polibatam'),
          position: _polibatamLocation,
          infoWindow: InfoWindow(title: 'Polibatam', snippet: 'Sumispace'),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  void _updateMarkers() {
    _markers.clear(); // Clear existing markers

    // Add markers
    _markers.add(
      Marker(
        markerId: MarkerId('polibatamLocation'),
        position: _polibatamLocation,
        infoWindow: InfoWindow(
          title: 'Polibatam',
          snippet: 'Batam',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('sumiSpaceLocation'),
        position: _sumiSpaceLocation,
        infoWindow: InfoWindow(
          title: 'Sumi Space',
          snippet: 'Batam',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('anteresStudioLocation'),
        position: _anteresStudioLocation,
        infoWindow: InfoWindow(
          title: 'Anteres Studio',
          snippet: 'Batam',
        ),
      ),
    );
  }

  // Method to calculate distance between two points
  double _calculateDistance(List<LatLng> points) {
    double distance = 0;
    for (int i = 0; i < points.length - 1; i++) {
      distance += _coordinateDistance(
        points[i].latitude,
        points[i].longitude,
        points[i + 1].latitude,
        points[i + 1].longitude,
      );
    }
    return distance;
  }

  // Method to calculate distance between two coordinates
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            if (_currentIndex == 0)
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _polibatamLocation,
                  zoom: 15.0,
                ),
                markers: _markers,
                polylines: _routePolylines,
              ),
            Positioned(
              top: 40.0,
              left: 16.0,
              child: Text(
                'Lokasi',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 40.0,
              right: 16.0,
              child: Text(
                'Mollery',
                style: TextStyle(
                  fontSize: 16.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Pesanan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_pin),
              label: 'Lokasi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
          currentIndex: 2,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaketApp()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PesananPage2()),
                );
                break;
              case 2:
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Tampilan()),
                );
                break;
            }
          },
          backgroundColor: Color(0xFF232D3F),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          elevation: 10,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
