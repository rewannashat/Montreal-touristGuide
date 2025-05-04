import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../resources/font-manager.dart';
import '../Main-viewModel/main_cubit.dart';

class MapDirectionPage extends StatefulWidget {
  const MapDirectionPage({super.key});

  @override
  State<MapDirectionPage> createState() => _MapDirectionPageState();
}

class _MapDirectionPageState extends State<MapDirectionPage> {

  LatLng? userLatLng;


  @override
  void initState() {
    super.initState();
    MainCubit().getCurrentLocation().then((latLng) {
      setState(() {
       userLatLng = latLng;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:  Color(0xffd0b3de),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 70.w),
                  Text(
                    "Map Direction",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight:
                        FontWeightManager
                            .semiBold,
                        color: Colors.black,
                        fontFamily: FontManager
                            .fontFamilyInriaSans,
                        fontSize: 20.sp)
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Map with markers
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: SizedBox(
                  height: 300.h,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: userLatLng ?? LatLng(30.87605680, 29.74260400),
                      zoom: 14,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId("A"),
                        position: LatLng(30.87605680, 29.74260400),
                        infoWindow: InfoWindow(title: "City Center"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                      ),
                      if (userLatLng != null)
                        Marker(
                          markerId: MarkerId("user_location"),
                          position: userLatLng!,
                          infoWindow: InfoWindow(title: "You are here"),
                          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                        ),
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Info Card
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Hotel Image
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(20.r),
                        child: Image.asset(
                          'assets/images/rec.png',
                          width: 90.w,
                          height: 100.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),

                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLocationRow("B", "Hilton Garden", Colors.amber, Icons.location_on),
                          SizedBox(height: 8.h),
                          _buildLocationRow("A", "city center", Colors.blueGrey, Icons.location_pin),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapMarker(String label, Color color) {
    return Column(
      children: [
        Icon(Icons.location_on, size: 50.sp, color: color),
        Positioned.fill(
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationRow(String tag, String name, Color color, IconData icon) {
    return Row(
      children: [
        // Circle tag
        CircleAvatar(
          radius: 12.r,
          backgroundColor: color,
          child: Text(
            tag,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        // Text
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),
        Icon(icon, color: color, size: 16.sp),
      ],
    );
  }
}
