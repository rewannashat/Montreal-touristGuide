import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:montreal_tourist/presentation/screens/Home/Main-view/seeAllPlace_view.dart';
import 'package:montreal_tourist/presentation/screens/Home/Main-viewModel/main_cubit.dart';
import 'package:montreal_tourist/presentation/screens/Home/Main-viewModel/main_states.dart';

import '../../../resources/font-manager.dart';
import '../Main-Model/hotelCard_model.dart';
import 'allMap_view.dart';
import 'mainDetails_view.dart';
import 'map_view.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
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
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              filled: true,
                              hintStyle:
                                  const TextStyle(color: Color(0xFF757575)),
                              fillColor: const Color(0xFF979797).withOpacity(0.1),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Search",
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Color(0xffA168BE),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AllMapView(),));
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
                BlocBuilder<MainCubit,MainState>(
                  builder: (context, state) {
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
                            itemCount: hotels.length,
                            itemBuilder: (context, index) {
                              final hotel = hotels[index];
                              return Padding(
                                padding: EdgeInsets.only(right: 12.w),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainDetailsView(),));
                                  },
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(20.r),
                                    shadowColor: Colors.black26,
                                    child: Container(
                                      width: 220.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.r),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(20.r)),
                                            child: Image.asset(
                                              hotel.imagePath,
                                              height: 160.h,
                                              width: 220.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  hotel.title,
                                                  style: TextStyle(
                                                    fontSize: 20.sp,
                                                    fontWeight:
                                                        FontWeightManager.semiBold,
                                                    color: Colors.black,
                                                    fontFamily: 'InriaSans',
                                                  ),
                                                ),
                                                SizedBox(height: 6.h),
                                                Row(
                                                  children: [
                                                    Icon(Icons.location_on,
                                                        color: Color(0xffA168BE),
                                                        size: 14.sp),
                                                    SizedBox(width: 4.w),
                                                    Text(
                                                      hotel.location,
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight: FontWeightManager
                                                            .semiBold,
                                                        color: Colors.black,
                                                        fontFamily: 'InriaSans',
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Icon(Icons.star,
                                                        color: Color(0xffFFCD0F),
                                                        size: 14.sp),
                                                    SizedBox(width: 2.w),
                                                    Text(
                                                      hotel.rating.toStringAsFixed(2),
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight: FontWeightManager
                                                            .semiBold,
                                                        color: Color(0xff979797),
                                                        fontFamily: 'InriaSans',
                                                      ),
                                                    ),
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
                    final categories = cubit.categories;
                    final selectedIndex = cubit.selectedCategoryIndex;
                    final hotels = cubit.filteredHotels;

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
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SeeAllView(),));
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
                            separatorBuilder: (_, __) => const SizedBox(width: 16),
                            itemBuilder: (context, index) {
                              final isSelected = cubit.selectedCategoryIndex == index;
                              return GestureDetector(
                                onTap: () => cubit.selectCategory(index),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.purple.shade100 : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      cubit.categories[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: isSelected ? Colors.black : Colors.grey,
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
                        SizedBox(
                          height: 115.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: hotels.length,
                            itemBuilder: (context, index) {
                              final hotel = hotels[index];
                              return Container(
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
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        child: Image.asset(
                                          hotel.imagePath,
                                          width: 90.w,
                                          height: 100.h,
                                          fit: BoxFit.cover,
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
                                            Text(hotel.title,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeightManager
                                                            .semiBold,
                                                    color: Colors.black,
                                                    fontFamily: FontManager
                                                        .fontFamilyInriaSans,
                                                    fontSize: 16.sp)),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                const Icon(Icons.location_on,
                                                    size: 14,
                                                    color: Colors.purple),
                                                const SizedBox(width: 4),
                                                Text(hotel.location,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeightManager
                                                                .semiBold,
                                                        color: Colors.black,
                                                        fontFamily: FontManager
                                                            .fontFamilyInriaSans,
                                                        fontSize: 11.sp)),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                const Icon(Icons.star,
                                                    size: 14,
                                                    color: Colors.orange),
                                                const SizedBox(width: 4),
                                                Text(
                                                  '${hotel.rating} ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeightManager
                                                              .semiBold,
                                                      color: Color(0xff979797),
                                                      fontFamily: FontManager
                                                          .fontFamilyInriaSans,
                                                      fontSize: 11.sp),
                                                ),
                                                Text(
                                                  '(reviews)',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeightManager
                                                              .semiBold,
                                                      color: Color(0xff979797),
                                                      fontFamily: FontManager
                                                          .fontFamilyInriaSans,
                                                      fontSize: 11.sp),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
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
