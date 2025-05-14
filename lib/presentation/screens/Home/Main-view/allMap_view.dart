import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../Main-viewModel/main_cubit.dart';
import '../Main-viewModel/main_states.dart';

class AllMapView extends StatefulWidget {
  const AllMapView({super.key});

  @override
  State<AllMapView> createState() => _AllMapViewState();
}

class _AllMapViewState extends State<AllMapView> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {}; // To store markers




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            if (state is MainLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MainError) {
              return Center(child: Text('Error: ${state.error}'));
            } else if (state is MainSuccess) {
              // Get the places from the cubit
              final allPlaces = BlocProvider.of<MainCubit>(context).allPlaces;

              // Set markers for all the places
              _markers = allPlaces.map((place) {
                return Marker(
                  markerId: MarkerId(place['name']),
                  position: LatLng(place['location']['latitude'], place['location']['longitude']),
                  infoWindow: InfoWindow(title: place['name']),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                );
              }).toSet();

              return Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(45.5031, -73.5650),
                      zoom: 14,
                    ),
                    markers: _markers,
                    onMapCreated: (controller) {
                      mapController = controller;
                    },
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    compassEnabled: true,
                    onCameraMove: (position) {
                      // You can do something with the camera position if needed
                    },
                  ),
                  Positioned(
                    top: 40,
                    left: 16,
                    child: InkWell(
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
                          color: Color(0xffd0b3de).withOpacity(0.7),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return Center(child: Text('No places available.'));
          },
        ),
      ),
    );
  }
}
