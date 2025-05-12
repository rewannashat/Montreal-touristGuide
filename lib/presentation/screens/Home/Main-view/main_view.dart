import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montreal_tourist/presentation/screens/Home/Main-view/seeAllPlace_view.dart';
import 'package:montreal_tourist/presentation/screens/Home/Main-viewModel/main_cubit.dart';
import 'package:montreal_tourist/presentation/screens/Home/Main-viewModel/main_states.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/font-manager.dart';
import '../Main-Model/hotelCard_model.dart';
import 'allMap_view.dart';
import 'mainDetails_view.dart';
import 'map_view.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});



  @override
  Widget build(BuildContext context) {

    final TextEditingController searchController = TextEditingController();


    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 15),
          child: BlocProvider(
            create: (_) => MainCubit(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 30),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 260.w,
                        child: Form(
                          child: TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                              filled: true,
                              hintStyle: const TextStyle(color: Color(0xFF757575)),
                              fillColor: const Color(0xFF979797).withOpacity(0.1),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Search",
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Color(0xffA168BE),
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              MainCubit.get(context).searchPlaces(value);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllMapView(),
                              ));
                        },
                        child: SizedBox(
                          width: 50.w,
                          height: 45.h,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF979797).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Icon(
                              Icons.location_on,
                              color: Color(0xffA168BE),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// ListView Data
                BlocBuilder<MainCubit, MainState>(
                  builder: (context, state) {
                    final cubit = MainCubit.get(context);
                    if (state is MainLoading) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Top hotels',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeightManager.semiBold,
                              color: Colors.black,
                              fontFamily: 'InriaSans',
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            height: 250.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3, // Simulated loading items
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 12.w),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      width: 220.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 160.h,
                                            width: 220.w,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(
                                                          20.r)),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 20.h,
                                                  width: 120.w,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(height: 6.h),
                                                Container(
                                                  height: 14.h,
                                                  width: 180.w,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Top hotels',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeightManager.semiBold,
                            color: Colors.black,
                            fontFamily: 'InriaSans',
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                            height: 250.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit.topHotels.length,
                              itemBuilder: (context, index) {
                                final hotel = cubit.topHotels[index];
                                return Padding(
                                  padding: EdgeInsets.only(right: 12.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainDetailsView(
                                            hotel: cubit.topHotels[index],
                                            heroTag: 'hotelImage_$index',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(20.r),
                                      shadowColor: Colors.black26,
                                      child: Container(
                                        width: 220.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            (hotel['imageUrl'] == null ||
                                                    (hotel['imageUrl']
                                                            as String)
                                                        .isEmpty)
                                                ? Hero(
                                                    tag: 'hotelImage_$index',
                                                    child: SvgPicture.asset(
                                                      'assets/images/uploadFailedIllistration.svg',
                                                      fit: BoxFit.cover,
                                                      height: 160.h,
                                                      width: 220.w,
                                                    ),
                                                  )
                                                : Hero(
                                                    tag: 'hotelImage_$index',
                                                    child: Image.network(
                                                      hotel['imageUrl'],
                                                      height: 160.h,
                                                      width: 220.w,
                                                      fit: BoxFit.cover,
                                                      errorBuilder:
                                                          (_, __, ___) =>
                                                              SvgPicture.asset(
                                                                'assets/images/uploadFailedIllistration.svg',
                                                        fit: BoxFit.cover,
                                                        height: 160.h,
                                                        width: 220.w,
                                                      ),
                                                    ),
                                                  ),
                                            Padding(
                                              padding: EdgeInsets.all(10.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      hotel['name'] ??
                                                          'No Hotel Name',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        overflow:
                                                            TextOverflow.clip,
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeightManager
                                                                .semiBold,
                                                        color: Colors.black,
                                                        fontFamily: 'InriaSans',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 6.h),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons.location_on,
                                                              color: Color(
                                                                  0xffA168BE),
                                                              size: 14.sp),
                                                          SizedBox(width: 4.w),
                                                          Text(
                                                            'Lat: ${hotel['location']['latitude'].toStringAsFixed(2)}, Long: ${hotel['location']['longitude'].toStringAsFixed(2)}',
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeightManager
                                                                      .semiBold,
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'InriaSans',
                                                            ),
                                                          ),
                                                          SizedBox(width: 4.w),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.star,
                                                              color: Color(
                                                                  0xffFFCD0F),
                                                              size: 14.sp),
                                                          Text(
                                                            '4.80',
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeightManager
                                                                      .semiBold,
                                                              color: Color(
                                                                  0xff979797),
                                                              fontFamily:
                                                                  'InriaSans',
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
                      ],
                    );
                  },
                ),

                SizedBox(
                  height: 30.h,
                ),

                /// Others ListView Data
                BlocBuilder<MainCubit, MainState>(
                  builder: (context, state) {
                    final cubit = MainCubit.get(context);
                    final places = cubit.filteredPlaces;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Other’s places',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeightManager.semiBold,
                                color: Colors.black,
                                fontFamily: 'InriaSans',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SeeAllView(),
                                    ));
                              },
                              child: Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeightManager.semiBold,
                                  color: Color(0xffA168BE),
                                  fontFamily: 'InriaSans',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),

                        // Category List
                        SizedBox(
                          height: 40.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.categories.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 16),
                            itemBuilder: (context, index) {
                              final isSelected =
                                  cubit.selectedCategoryIndex == index;
                              return GestureDetector(
                                onTap: () => cubit.selectCategory(index),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.purple.shade100
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      cubit.categories[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: isSelected
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Hotels List
                        BlocBuilder<MainCubit, MainState>(
                            builder: (context, state) {
                          if (state is MainLoading) {
                            return SizedBox(
                              height: 115.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3, // Simulated loading items
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: 260.w,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              width: 90.w,
                                              height: 100.h,
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: 14.h,
                                                      color: Colors.grey,
                                                    ),
                                                    Container(
                                                      width: 140.w,
                                                      height: 10.h,
                                                      color: Colors.grey,
                                                    ),
                                                    Container(
                                                      width: 100.w,
                                                      height: 10.h,
                                                      color: Colors.grey,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }

                          if (cubit.filteredPlaces.isEmpty) {
                            return Center(child: Text('No places found'));
                          }
                          return SizedBox(
                            height: 115.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: places.length,
                              itemBuilder: (context, index) {
                                final place = places[index];
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MainDetailsView(
                                          hotel: cubit.filteredPlaces[index],
                                          heroTag: 'PlacessImage_$index',
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 260.w,
                                    margin: const EdgeInsets.only(right: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10,
                                            color: Colors.grey.shade200)
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: (place['imageUrl'] == null ||
                                                  (place['imageUrl'] as String)
                                                      .isEmpty)
                                              ? Hero(
                                              tag: 'PlacessImage_$index',
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
                                              tag: 'PlacessImage_$index',
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(20.r),
                                                    child: Image.network(
                                                      place['imageUrl'],
                                                      width: 90.w,
                                                      height: 100.h,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (_, __, ___) =>
                                                          SvgPicture.asset(
                                                            'assets/images/uploadFailedIllistration.svg',
                                                        fit: BoxFit.scaleDown,
                                                        width: 90.w,
                                                        height: 100.h,
                                                      ),
                                                    ),
                                                  ),
                                              ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                      place['name'] ?? 'No name',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeightManager
                                                                  .semiBold,
                                                          color: Colors.black,
                                                          fontFamily: FontManager
                                                              .fontFamilyInriaSans,
                                                          fontSize: 16.sp)),
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.location_on,
                                                        size: 14,
                                                        color: Colors.purple),
                                                    const SizedBox(width: 4),
                                                    Flexible(
                                                      child: Text(
                                                          'Lat: ${place['location']['latitude']}, Long: ${place['location']['longitude']}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeightManager
                                                                      .semiBold,
                                                              color: Colors.black,
                                                              fontFamily: FontManager
                                                                  .fontFamilyInriaSans,
                                                              fontSize: 11.sp)),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.star,
                                                        size: 14,
                                                        color: Colors.orange),
                                                    const SizedBox(width: 4),
                                                    /* Text(
                                                      '${'4.96'} ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeightManager
                                                                  .semiBold,
                                                          color:
                                                              Color(0xff979797),
                                                          fontFamily: FontManager
                                                              .fontFamilyInriaSans,
                                                          fontSize: 11.sp),
                                                    ),*/
                                                    Flexible(
                                                      child: Text(
                                                        place['description'] ??
                                                            'No Data for Description',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            overflow:
                                                                TextOverflow.clip,
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
                            ),
                          );
                        }),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
