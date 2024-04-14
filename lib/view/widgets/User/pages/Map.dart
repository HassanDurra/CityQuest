import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/view/widgets/User/pages/map_inputs/map_api_credientals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:convert';
import 'dart:core';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  List ListofPoints = [];
  final List<LatLng> Points = [];

  final TextEditingController pickupController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  bool isHovered = false;

  getCordinates() async {
    var response = await http
        .get(getRouteUrl("31.281291,72.320436", "31.269927,72.317392"));
    setState(() {
      if (response.statusCode == 200) {
        var data =
            jsonDecode(response.body)['features'][0]['geometry']['coordinates'];
        for (int i = 0; i < data[0].length; i++) {
          double lat = data[0][i][0];
          double long = data[0][i][1];
          Points.add(LatLng(lat, long));
        }
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialZoom: 15,
              initialCenter: LatLng(31.281291, 72.320436),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://maps.geoapify.com/v1/tile/osm-bright/{z}/{x}/{y}.png?apiKey=914dea0a4e48423e8af1c0ac35cac48a',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                // Plenty of other options available!
              ),
              MarkerLayer(
                markers: [
                  // User Pickup location Marker
                  Marker(
                      point: LatLng(31.281291, 72.320436),
                      width: 80,
                      height: 80,
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.green,
                              size: 40,
                            )
                          ],
                        ),
                      )),
                  // Destination Marker
                  Marker(
                      point: LatLng(31.269927, 72.317392),
                      width: 80,
                      height: 80,
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40,
                            )
                          ],
                        ),
                      )),
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
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: destinationController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Destination',
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) {
                        setState(() {
                          isHovered = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          isHovered = false;
                        });
                      },
                      child: InkWell(
                        onTap: () async {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: isHovered
                                ? GlobalColors.secondaryColor
                                : GlobalColors.mainColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              )
                            ],
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Ionicons.search,
                            color: Colors.white,
                          ),
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
            left: 0,
            right: 0,
            bottom: 50,
            child: InkWell(
              onTap: () {
                getCordinates();
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.all(10),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Ionicons.location_outline,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Set Current Location",
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
