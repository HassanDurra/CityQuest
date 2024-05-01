import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cityquest/view/widgets/User/pages/map_inputs/map_api_credientals.dart';
import 'package:cityquest/view/widgets/User/partial/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ionicons/ionicons.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  List<LatLng> points = [];
  late LatLng currentLocation = LatLng(0.0, 0.0);
  late String? currentLongitudeRoute;
  late String? currentlatitudeRoute;
  late LatLng destinationLocation = LatLng(24.8755064, 67.0410023);
  bool showCurrentLocation = false;
  double zoomLevel = 15.0;
  final TextEditingController destinationController = TextEditingController();
  
  get http => null;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getCordinates();
  }

  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Location Denied");
      LocationPermission ask = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final currentLongitude = currentPosition.longitude.toDouble();
      final currentLatitude = currentPosition.latitude.toDouble();
      setState(() {
        currentLocation = LatLng(currentLatitude, currentLongitude);
        currentLongitudeRoute = currentPosition.longitude.toString();
        currentlatitudeRoute = currentPosition.latitude.toString();
        showCurrentLocation = true;
      });
    }
  }

  getCordinates() async {
    points.clear();
    var response = await http.get(getRouteUrl(
        "${currentlatitudeRoute},${currentLongitudeRoute}",
        "24.8755064,67.0410023"));
    setState(() {
      if (response.statusCode == 200) {
        var data =
            jsonDecode(response.body)['features'][0]['geometry']['coordinates'];
        for (int i = 0; i < data[0].length; i++) {
          double long = data[0][i][1];
          double lat = data[0][i][0];
          points.add(LatLng(long, lat));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (showCurrentLocation)
            GestureDetector(
              onScaleUpdate: (details) {
                setState(() {
                  zoomLevel -= details.scale / 10;
                });
              },
              child: FlutterMap(
                key: ValueKey(currentLocation),
                options: MapOptions(
                  minZoom: zoomLevel,
                  maxZoom: zoomLevel,
                  initialZoom: zoomLevel,
                  initialCenter: currentLocation,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://maps.geoapify.com/v1/tile/osm-bright/{z}/{x}/{y}.png?apiKey=914dea0a4e48423e8af1c0ac35cac48a',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: currentLocation,
                        width: 80,
                        height: 80,
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.location_on,
                            color: Colors.green,
                            size: 40,
                          ),
                        ),
                      ),
                      Marker(
                        point: destinationLocation,
                        width: 80,
                        height: 80,
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (points.isNotEmpty)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: points,
                          color: Colors.blue,
                          strokeWidth: 5,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: destinationController,
                      decoration: InputDecoration(
                        hintText: 'Enter Destination',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Perform search
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    getCurrentLocation();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 8.0,
                  ),
                  child: Icon(Icons.location_on, color: Colors.green),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    getCordinates();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 8.0,
                  ),
                  child: Icon(Icons.directions, color: Colors.red),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      zoomLevel += 1.0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 8.0,
                  ),
                  child: Icon(Icons.add, color: Colors.blue),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      zoomLevel -= 1.0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 8.0,
                  ),
                  child: Icon(Icons.remove, color: Colors.blue),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Navbar(),
          ),
        ],
      ),
    );
  }
}
