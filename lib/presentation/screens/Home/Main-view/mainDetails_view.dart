import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../resources/constants/custom-staticwidget.dart';
import '../../../resources/font-manager.dart';
import '../Main-viewModel/main_cubit.dart';
import '../Main-viewModel/main_states.dart';
import 'map_view.dart';

class MainDetailsView extends StatelessWidget {
  final Map<String, dynamic> hotel;
  final String heroTag;

  const MainDetailsView({
    super.key,
    required this.hotel,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = MainCubit.get(context);


    final amenities = hotel['amenities'] ?? [];

    Map<String, IconData> amenityIcons = {
      'wifi': Icons.wifi,
      'bed': Icons.bed,
      'romanticFood': Icons.restaurant,
      'conditioner': Icons.hot_tub,
      'jacozy': Icons.bathtub,
    };

    final hasValidAmenities = amenities.any((a) => amenityIcons.containsKey(a));

    double lat = hotel['location']['latitude'];
    double lng = hotel['location']['longitude'];

    LatLng hotelLatLng = LatLng(lat, lng);

    String siteUrl = hotel['site'];

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // header
            Padding(
              padding:
                  EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 20),
              child: Stack(
                children: [
                  Hero(
                    tag: heroTag,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.network(
                        hotel['imageUrl'] ?? '',
                        height: 300.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: 300.h,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 300.h,
                          width: double.infinity,
                          color: Colors.grey,
                          child: SvgPicture.asset(
                            'assets/images/uploadFailedIllistration.svg',
                            fit: BoxFit.cover,
                            height: 300.h,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          color: Colors.transparent,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // data
            Padding(
              padding:
                  EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          hotel['name'] ?? 'No Hotel Name',
                          style: TextStyle(
                              fontWeight: FontWeightManager.semiBold,
                              color: Colors.black,
                              fontFamily: FontManager.fontFamilyInriaSans,
                              fontSize: 17.sp),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${hotel['location']['latitude'].toStringAsFixed(2)},${hotel['location']['longitude'].toStringAsFixed(2)}',
                            style: TextStyle(
                                fontWeight: FontWeightManager.regular,
                                color: Color(0xff666666),
                                fontFamily: FontManager.fontFamilyInriaSans,
                                fontSize: 13.sp),
                          ),
                          Icon(
                            Icons.location_on_outlined,
                            size: 18.sp,
                            color: Colors.purple,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 18.sp),
                          SizedBox(width: 4.w),
                          Text(
                            '4.96 (6.5k review)',
                            style: TextStyle(
                                fontWeight: FontWeightManager.regular,
                                color: Color(0xff666666),
                                fontFamily: FontManager.fontFamilyInriaSans,
                                fontSize: 13.sp),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapDirectionPage(
                                      targetLatLng: hotelLatLng,
                                      hotelName: hotel['name'],
                                      hotelImage: hotel['imageUrl'],
                                    ),
                                  ));
                            },
                            child: Text(
                              'Map Direction',
                              style: TextStyle(
                                  fontWeight: FontWeightManager.regular,
                                  color: Color(0xff666666),
                                  fontFamily: FontManager.fontFamilyInriaSans,
                                  fontSize: 13.sp),
                            ),
                          ),
                          Icon(Icons.directions_sharp,
                              color: Colors.purple, size: 18.sp),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  dividerList,
                ],
              ),
            ),

            // Amenities
            Padding(
              padding:
                  EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amenities',
                        style: TextStyle(
                            fontWeight: FontWeightManager.semiBold,
                            color: Colors.black,
                            fontFamily: FontManager.fontFamilyInriaSans,
                            fontSize: 18.sp),
                      ),
                      Text(
                        'more',
                        style: TextStyle(
                            fontWeight: FontWeightManager.regular,
                            color: Colors.purple,
                            fontFamily: FontManager.fontFamilyInriaSans,
                            fontSize: 18.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: hasValidAmenities
                          ? [
                              for (var amenity in amenities)
                                if (amenityIcons.containsKey(amenity))
                                  amenityIcon(amenityIcons[amenity]!),
                            ]
                          : [
                              amenityIcon(Icons.bed),
                              amenityIcon(Icons.restaurant),
                              amenityIcon(Icons.ac_unit),
                              amenityIcon(Icons.bathtub),
                            ],
                    ),
                  )
                ],
              ),
            ),

            // Describtion
            Padding(
              padding:
                  EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'About the place',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeightManager.semiBold,
                          color: Colors.black,
                          fontFamily: FontManager.fontFamilyInriaSans,
                          fontSize: 18.sp),
                    ),
                    Flexible(
                      child: Text(
                        hotel['description'] ?? 'No description available.',
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        style: TextStyle(
                            fontWeight: FontWeightManager.regular,
                            color: Color(0xff979797),
                            overflow: TextOverflow.clip,
                            fontFamily: FontManager.fontFamilyInriaSans,
                            fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h, top: 15.h),
                child: InkWell(
                  onTap: () async {
                    if (siteUrl != null && siteUrl != 'No Hotel site') {
                      await launch(siteUrl);
                    } else {
                      throw 'Could not launch $siteUrl';
                    }
                  },
                  child: Container(
                    width: 300.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Color(0xffA168BE),
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Go Site",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontFamily: 'InriaSans',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget amenityIcon(IconData iconData) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff979797)),
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Icon(iconData, size: 28.sp, color: Color(0xff979797)),
    );
  }
}
