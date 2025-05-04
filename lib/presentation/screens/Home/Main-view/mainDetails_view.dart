import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/constants/custom-staticwidget.dart';
import '../../../resources/font-manager.dart';
import 'map_view.dart';

class MainDetailsView extends StatelessWidget {
  const MainDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // header
            Padding(
              padding:  EdgeInsetsDirectional.symmetric(horizontal: 20 , vertical: 20),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.asset(
                      'assets/images/rec.png' ,
                      height:300.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
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
              padding:  EdgeInsetsDirectional.symmetric(horizontal: 20 , vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Le Centre Sheraton',
                        style: TextStyle(
                            fontWeight:
                            FontWeightManager
                                .semiBold,
                            color: Colors.black,
                            fontFamily: FontManager
                                .fontFamilyInriaSans,
                            fontSize: 17.sp),
                      ),
                      Row(
                        children: [
                          Text('500m city center' , style: TextStyle(
                              fontWeight:
                              FontWeightManager
                                  .regular,
                              color: Color(0xff666666),
                              fontFamily: FontManager
                                  .fontFamilyInriaSans,
                              fontSize: 13.sp),),
                          Icon(Icons.location_on_outlined, size: 18.sp , color: Colors.purple,),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 18.sp),
                          SizedBox(width: 4.w),
                          Text('4.96 (6.5k review)' , style: TextStyle(
                              fontWeight:
                              FontWeightManager
                                  .regular,
                              color:  Color(0xff666666),
                              fontFamily: FontManager
                                  .fontFamilyInriaSans,
                              fontSize: 13.sp),),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Map Direction',
                            style: TextStyle(
                                fontWeight:
                                FontWeightManager
                                    .regular,
                                color:  Color(0xff666666),
                                fontFamily: FontManager
                                    .fontFamilyInriaSans,
                                fontSize: 13.sp),
                          ),
                          Icon(Icons.directions_sharp, color: Colors.purple, size: 18.sp),

                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 30.h,),
                  dividerList,

                ],
              ),
            ),

            // Amenities
            Padding(
              padding:  EdgeInsetsDirectional.symmetric(horizontal: 20 , vertical: 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amenities',
                        style: TextStyle(
                            fontWeight:
                            FontWeightManager
                                .semiBold,
                            color:  Colors.black,
                            fontFamily: FontManager
                                .fontFamilyInriaSans,
                            fontSize: 18.sp),
                      ),
                      Text(
                        'more',
                        style: TextStyle(
                            fontWeight:
                            FontWeightManager
                                .regular,
                            color:  Colors.purple,
                            fontFamily: FontManager
                                .fontFamilyInriaSans,
                            fontSize: 18.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        amenityIcon(Icons.bed),
                        amenityIcon(Icons.restaurant),
                        amenityIcon(Icons.ac_unit),
                        amenityIcon(Icons.bathtub),
                        // Add more icons if needed
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Describtion
            Padding(
              padding:  EdgeInsetsDirectional.symmetric(horizontal: 20 , vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'About the place',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight:
                        FontWeightManager
                            .semiBold,
                        color:  Colors.black,
                        fontFamily: FontManager
                            .fontFamilyInriaSans,
                        fontSize: 18.sp),
                  ),
                  Text(
                    'About the place About the place About the place About the place About the place About the place About the place About the place ..........',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight:
                        FontWeightManager
                            .regular,
                        color:  Color(0xff979797),
                        fontFamily: FontManager
                            .fontFamilyInriaSans,
                        fontSize: 14.sp),
                  ),

                ],
              ),
            ),

            // Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h , top: 15.h),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MapDirectionPage(),));
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
