import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/font-manager.dart';
import '../Main-viewModel/main_cubit.dart';
import '../Main-viewModel/main_states.dart';
import 'animation_view.dart';
import 'mainDetails_view.dart';

class SeeAllView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (_) => MainCubit(),
      child: Scaffold(
        backgroundColor: Color(0xFFF6F6F6),
        body: SafeArea(
          child: Column(
            children: [
              // App bar
              Row(
                children: [
                  InkWell(
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
                        color: Color(0xffd0b3de),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 70.w),
                  Text("Places All",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeightManager.semiBold,
                          color: Colors.black,
                          fontFamily: FontManager.fontFamilyInriaSans,
                          fontSize: 20.sp)),
                ],
              ),
              SizedBox(height: 20.h),

              // Categories (tabs)
              BlocBuilder<MainCubit, MainState>(
                builder: (context, state) {
                  final cubit = MainCubit.get(context);
                  return Container(
                    height: 36,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: cubit.categories.length,
                      itemBuilder: (context, index) {
                        final isSelected = index == cubit.selectedCategoryIndex;
                        return GestureDetector(
                          onTap: () => cubit.selectCategory(index),
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color(0xffeadef0)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              cubit.categories[index],
                              style: TextStyle(
                                  color:
                                      isSelected ? Colors.black : Colors.grey,
                                  fontWeight: FontWeightManager.light,
                                  fontSize: 15.sp),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              SizedBox(
                height: 10.h,
              ),
              // Filtered hotel list
              Expanded(
                child: BlocBuilder<MainCubit, MainState>(
                  builder: (context, state) {
                    final cubit = MainCubit.get(context);
                    final places = cubit.filteredHotels;

                    if (state is MainLoading) {
                      return ListView.builder(
                        itemCount: 4, // Placeholder items count
                        padding: EdgeInsets.only(bottom: 16),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 120.h,
                                padding: EdgeInsets.only(left: 10, top: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90.w,
                                      height: 100.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              height: 14.h,
                                              width: 140.w,
                                              color: Colors.grey,
                                            ),
                                            Container(
                                              height: 12.h,
                                              width: 100.w,
                                              color: Colors.grey,
                                            ),
                                            Container(
                                              height: 12.h,
                                              width: 80.w,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }

                    if (cubit.filteredPlaces.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(height: 30.h,),
                            FloatingSvgImage(),
                            SizedBox(height: 30.h,),
                            Text('Empty Cart' , style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.sp,
                                fontFamily: FontManager.fontFamilyInriaSans

                            ),),
                          ],
                        ),
                      );
                    }


                    return ListView.builder(
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        final place = places[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MainDetailsView(
                                      hotel: cubit.filteredPlaces[index],
                                      heroTag: 'filterImage_$index',
                                    )));
                          },
                          child: Container(
                            height: 120.h,
                            margin: EdgeInsets.only(bottom: 16),
                            padding: EdgeInsets.only(left: 10, top: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                (place['imageUrl'] == null ||
                                        (place['imageUrl'] as String).isEmpty)
                                    ? Hero(
                                  tag: 'filterImage_$index',
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          child: SvgPicture.asset(
                                            'assets/images/uploadFailedIllistration.svg',
                                            fit: BoxFit.scaleDown,
                                            width: 90.w,
                                            height: 100.h,
                                          ),
                                        ),
                                    )
                                    : Hero(
                                  tag: 'filterImage_$index',
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          child: Image.network(
                                            place['imageUrl'],
                                            width: 90.w,
                                            height: 100.h,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return SizedBox(
                                                width: 90.w,
                                                height: 100.h,
                                                child: Center(
                                                  child: CircularProgressIndicator(),
                                                ),
                                              );
                                            },
                                            errorBuilder: (_, __, ___) => SvgPicture.asset(
                                              'assets/images/uploadFailedIllistration.svg',
                                              fit: BoxFit.scaleDown,
                                              width: 90.w,
                                              height: 100.h,
                                            ),
                                          )
                                        ),
                                    ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(place['name'] ?? 'No name',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on_outlined,
                                                size: 16, color: Colors.purple),
                                            SizedBox(width: 4),
                                            Flexible(
                                              child: Text(
                                                  'Lat: ${place['location']['latitude'].toStringAsFixed(3)}, Long: ${place['location']['longitude'].toStringAsFixed(3)}',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[700])),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                size: 16, color: Colors.orange),
                                            SizedBox(width: 4),
                                            Flexible(
                                              child: Text(
                                                place['description'] ?? 'No Data for Description',
                                                maxLines: 1,
                                                style: TextStyle(
                                                    overflow: TextOverflow.clip,
                                                    fontWeight:
                                                    FontWeightManager
                                                        .semiBold,
                                                    color:
                                                    Color(0xff979797),
                                                    fontFamily: FontManager
                                                        .fontFamilyInriaSans,
                                                    fontSize: 11.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
