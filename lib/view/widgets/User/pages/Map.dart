import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/view/widgets/User/pages/map_inputs/map_api_credientals.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:convert';
import 'dart:async';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  List ListofPoints = [];
  final List<LatLng> Points = [];
  late LatLng currentLocation = LatLng(0.0, 0.0);
  late LatLng destinationLocation = LatLng(31.269927, 72.317392);
  bool showCurrentLocation = false;
  double zoomLevel = 15.0;

  final TextEditingController pickupController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  bool isHovered = false;

  // Get User Current Location
  void getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Location Denied");
      LocationPermission ask = await Geolocator.requestPermission();
    } else {
      Position currentPostion = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final currentLongitude = currentPostion.longitude.toDouble();
      final currentLatitude = currentPostion.latitude.toDouble();
      setState(() {
        currentLocation = LatLng(currentLatitude, currentLongitude);
        showCurrentLocation = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  getCordinates() async {
    var response = await http
        .get(getRouteUrl("31.281291,72.320436", "31.269927,72.317392"));
    setState(() {
      if (response.statusCode == 200) {
        var data =
            jsonDecode(response.body)['features'][0]['geometry']['coordinates'];
        for (int i = 0; i < data[0].length; i++) {
          double long = data[0][i][1];
          double lat = data[0][i][0];
          Points.add(LatLng(long, lat));
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
            FlutterMap(
              options: MapOptions(
                minZoom: 5,
                maxZoom: 20,
                zoom: zoomLevel,
                center: currentLocation,
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
                      child:InkWell(
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
                      child:InkWell(
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
                if (Points.isNotEmpty)
                  PolylineLayer(
                    polylineCulling: false,
                    polylines: [
                      Polyline(
                        points: Points,
                        color: Colors.blue,
                        strokeWidth: 5,
                      ),
                    ],
                  ),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          zoomLevel = zoomLevel + 1.0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        setState(() {
                          zoomLevel = zoomLevel - 1.0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.remove,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          Positioned(
            right: 16,
            bottom: 120,
            child: InkWell(
              onTap: () {
                getCurrentLocation();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: GlobalColors.mainColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Icon(
                      Ionicons.location_outline,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Get Route",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
