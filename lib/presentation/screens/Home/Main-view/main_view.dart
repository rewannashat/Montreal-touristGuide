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
    /// images not Found
    const uploadFailedIllistration =
        '''<svg width="1080" height="1080" viewBox="0 0 1080 1080" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M378 809C154.5 782.5 232.5 494.5 421.5 546.5C446.5 275.5 820.5 310.5 805.5 576.5C954.5 538.5 1029.5 763.5 851 807L378 809Z" fill="#DDDDDD"/>
<path d="M316.5 784C293.933 783.993 271.726 778.35 251.893 767.584C232.061 756.817 215.231 741.268 202.933 722.347C190.634 703.426 183.256 681.734 181.467 659.238C179.679 636.742 183.537 614.156 192.692 593.53C201.847 572.904 216.008 554.891 233.891 541.126C251.773 527.361 272.81 518.281 295.092 514.708C317.374 511.136 340.196 513.186 361.485 520.671C382.774 528.156 401.856 540.839 417 557.57" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M360.5 520.5C360.5 413.91 446.91 332.5 553.5 332.5C660.09 332.5 746.5 418.91 746.5 525.5C746.521 545.524 743.424 565.429 737.32 584.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M744.87 550.63C761.164 546.201 778.217 545.304 794.886 548.001C811.555 550.698 827.455 556.926 841.521 566.268C855.587 575.61 867.495 587.849 876.446 602.167C885.397 616.485 891.185 632.551 893.422 649.287C895.66 666.024 894.295 683.046 889.419 699.212C884.543 715.378 876.268 730.316 865.15 743.024C854.031 755.733 840.325 765.918 824.95 772.899C809.575 779.879 792.886 783.494 776 783.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M316.5 783.5H776.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M458 656.5C482.577 656.5 502.5 636.577 502.5 612C502.5 587.423 482.577 567.5 458 567.5C433.423 567.5 413.5 587.423 413.5 612C413.5 636.577 433.423 656.5 458 656.5Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M458 645.5C476.502 645.5 491.5 630.502 491.5 612C491.5 593.498 476.502 578.5 458 578.5C439.498 578.5 424.5 593.498 424.5 612C424.5 630.502 439.498 645.5 458 645.5Z" fill="#0E0E0E"/>
<path d="M477 599C479.209 599 481 597.209 481 595C481 592.791 479.209 591 477 591C474.791 591 473 592.791 473 595C473 597.209 474.791 599 477 599Z" fill="white"/>
<path d="M470 608C471.105 608 472 607.105 472 606C472 604.895 471.105 604 470 604C468.895 604 468 604.895 468 606C468 607.105 468.895 608 470 608Z" fill="white"/>
<path d="M632 656.5C656.577 656.5 676.5 636.577 676.5 612C676.5 587.423 656.577 567.5 632 567.5C607.423 567.5 587.5 587.423 587.5 612C587.5 636.577 607.423 656.5 632 656.5Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M632 645.5C650.502 645.5 665.5 630.502 665.5 612C665.5 593.498 650.502 578.5 632 578.5C613.498 578.5 598.5 593.498 598.5 612C598.5 630.502 613.498 645.5 632 645.5Z" fill="#0E0E0E"/>
<path d="M651 599C653.209 599 655 597.209 655 595C655 592.791 653.209 591 651 591C648.791 591 647 592.791 647 595C647 597.209 648.791 599 651 599Z" fill="white"/>
<path d="M644 608C645.105 608 646 607.105 646 606C646 604.895 645.105 604 644 604C642.895 604 642 604.895 642 606C642 607.105 642.895 608 644 608Z" fill="white"/>
<path d="M507 708C542.17 687.32 570.45 694.36 595 708" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M553.01 893.96C596.646 893.96 632.02 858.586 632.02 814.95C632.02 771.314 596.646 735.94 553.01 735.94C509.374 735.94 474 771.314 474 814.95C474 858.586 509.374 893.96 553.01 893.96Z" fill="#BCBCBC"/>
<path d="M554.72 893.69C598.356 893.69 633.73 858.316 633.73 814.68C633.73 771.044 598.356 735.67 554.72 735.67C511.084 735.67 475.71 771.044 475.71 814.68C475.71 858.316 511.084 893.69 554.72 893.69Z" stroke="#0E0E0E" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M554.74 854.17V793.7" stroke="#0E0E0E" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M535.59 812.09L554.24 786.27L573.6 812.09" stroke="#0E0E0E" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M260.46 479.5C304.643 479.5 340.46 443.683 340.46 399.5C340.46 355.317 304.643 319.5 260.46 319.5C216.277 319.5 180.46 355.317 180.46 399.5C180.46 443.683 216.277 479.5 260.46 479.5Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M798 213.5C809.874 213.5 819.5 203.874 819.5 192C819.5 180.126 809.874 170.5 798 170.5C786.126 170.5 776.5 180.126 776.5 192C776.5 203.874 786.126 213.5 798 213.5Z" fill="#BCBCBC"/>
<path d="M806 265C810.418 265 814 261.418 814 257C814 252.582 810.418 249 806 249C801.582 249 798 252.582 798 257C798 261.418 801.582 265 806 265Z" fill="#BCBCBC"/>
<path d="M734.5 242C745.27 242 754 233.27 754 222.5C754 211.73 745.27 203 734.5 203C723.73 203 715 211.73 715 222.5C715 233.27 723.73 242 734.5 242Z" fill="#BCBCBC"/>
<path d="M146 873C150.971 873 155 868.971 155 864C155 859.029 150.971 855 146 855C141.029 855 137 859.029 137 864C137 868.971 141.029 873 146 873Z" fill="#BCBCBC"/>
<path d="M216.5 899C226.165 899 234 891.165 234 881.5C234 871.835 226.165 864 216.5 864C206.835 864 199 871.835 199 881.5C199 891.165 206.835 899 216.5 899Z" fill="#BCBCBC"/>
<path d="M174 955C189.464 955 202 942.464 202 927C202 911.536 189.464 899 174 899C158.536 899 146 911.536 146 927C146 942.464 158.536 955 174 955Z" fill="#BCBCBC"/>
<path d="M776 145L754 123" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M806 143L814 113" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M831.5 153.5L844.5 148.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M202.5 859.5L192.5 842.5" stroke="#231F20" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M222.5 854.5L233.5 837.5" stroke="#231F20" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M165.5 340.5L106.5 319.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M223.5 301.5L194.85 212.37" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M307.5 307.5L331.5 254.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M293 369L227 435" stroke="#0E0E0E" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M227 369L293 435" stroke="#0E0E0E" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''';

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
                              fillColor:
                                  const Color(0xFF979797).withOpacity(0.1),
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
                                                    child: SvgPicture.string(
                                                      uploadFailedIllistration,
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
                                                              SvgPicture.string(
                                                        uploadFailedIllistration,
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
                                                            'Lat: ${hotel['location']['latitude']}, Long: ${hotel['location']['longitude']}',
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
                    final places = cubit.filteredHotels;

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
                                        child: (place['imageUrl'] == null ||
                                                (place['imageUrl'] as String)
                                                    .isEmpty)
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                child: SvgPicture.string(
                                                  uploadFailedIllistration,
                                                  fit: BoxFit.scaleDown,
                                                  width: 90.w,
                                                  height: 100.h,
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                child: Image.network(
                                                  place['imageUrl'],
                                                  width: 90.w,
                                                  height: 100.h,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) =>
                                                      SvgPicture.string(
                                                    uploadFailedIllistration,
                                                    fit: BoxFit.scaleDown,
                                                    width: 90.w,
                                                    height: 100.h,
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
