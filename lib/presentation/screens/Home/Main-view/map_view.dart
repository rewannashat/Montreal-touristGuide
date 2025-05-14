import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/font-manager.dart';
import '../Main-viewModel/main_cubit.dart';

class MapDirectionPage extends StatefulWidget {
  final LatLng targetLatLng;
  final String hotelName;
  final String hotelImage;

  const MapDirectionPage({super.key, required this.targetLatLng,  required this.hotelName,
    required this.hotelImage,});


  @override
  State<MapDirectionPage> createState() => _MapDirectionPageState();
}

class _MapDirectionPageState extends State<MapDirectionPage> {






  @override
  Widget build(BuildContext context) {

    final LatLng userLatLng = LatLng(45.509062, -73.553363);




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
                      target: widget.targetLatLng,
                      zoom: 14,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId("A"),
                        position: widget.targetLatLng,
                        infoWindow: InfoWindow(title: "Hotel Location"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                      ),
                      Marker(
                        markerId: MarkerId("B"),
                        position: userLatLng,
                        infoWindow: InfoWindow(title: "City Center"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                      ),
                    },
                    polylines: {
                      Polyline(
                        polylineId: PolylineId("route"),
                        color: Colors.purple,
                        width: 4,
                        points: [
                          widget.targetLatLng,
                          userLatLng,
                        ],
                      ),
                    },
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
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
                        child: Image.network(
                          widget.hotelImage,
                          width: 90.w,
                          height: 100.h,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: 90.w,
                                height: 100.h,
                                color: Colors.grey,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 90.w,
                            height: 100.h,
                            color: Colors.grey,
                            child:SvgPicture.string(
                              'assets/images/uploadFailedIllistration.svg',
                              fit: BoxFit.cover,
                              width: 90.w,
                              height: 100.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),

                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLocationRow("B", widget.hotelName, Colors.amber, Icons.location_on),
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
            maxLines: 1,
            style: TextStyle(
              overflow: TextOverflow.clip,
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
