import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AllMapView extends StatefulWidget {

  const AllMapView({super.key});

  @override
  State<AllMapView> createState() => _AllMapViewState();
}

class _AllMapViewState extends State<AllMapView> {


  late GoogleMapController mapController;

  final LatLng startPoint = LatLng(45.5017, -73.5673); // Example: Montreal
  final LatLng endPoint = LatLng(45.5057, -73.5620);   // Example destination

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  void _setMarkers() {
    _markers = {
      Marker(
        markerId: MarkerId('start'),
        position: startPoint,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      ),
      Marker(
        markerId: MarkerId('end'),
        position: endPoint,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      ),
    };
  }

  void _setPolyline() {
    _polylines = {
      Polyline(
        polylineId: PolylineId('route'),
        color: Colors.purple,
        width: 5,
        points: [startPoint, endPoint],
      ),
    };
  }


  @override
  void initState() {
    super.initState();
    _setMarkers();
    _setPolyline();
  }


  @override
  Widget build(BuildContext context) {


    return SafeArea(child: Scaffold(
      body: Stack(
        children: [
          /// Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(45.5031, -73.5650), // centered view
              zoom: 14,
            ),
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (controller) {
              mapController = controller;
            },
            zoomControlsEnabled: false,
            myLocationEnabled: false,
            compassEnabled: false,
          ),

          /// Back Button
          Positioned(
            top: 40,
            left: 16,
            child:  InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                margin: EdgeInsetsDirectional.symmetric(horizontal: 10),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:  Color(0xffd0b3de).withOpacity(0.7),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          /// Bottom Info Card
          Positioned(
            bottom: 24,
            left: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/rec.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hilton Garden',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: Colors.purple, size: 16),
                            SizedBox(width: 4),
                            Text('500m city center',
                                style: TextStyle(color: Colors.grey[700])),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 16),
                            SizedBox(width: 4),
                            Text('4.96 (6.5k review)'),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
