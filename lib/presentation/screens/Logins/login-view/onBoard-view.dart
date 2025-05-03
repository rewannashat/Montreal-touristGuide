import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/font-manager.dart';
import '../../Home/Main-view/main_view.dart';

class OnBoardView extends StatelessWidget {
  const OnBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF9666d1),
                Color(0xFF9664ca),
                Color(0xFF9e66c13),
                Color(0xFF9c64c0),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.7,
                  child: Image.asset(
                    'assets/images/onboard3.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 48.sp,
                          fontWeight: FontWeightManager.regular,
                          color: Colors.white,
                          fontFamily: 'InriaSans',
                        ),
                        children: [
                          const TextSpan(text: 'MONTREAL\n'),
                          TextSpan(
                            text: 'Tourist Guide\n',
                            style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeightManager.light,
                              color: const Color(0xffFFC421),
                            ),
                          ),
                          TextSpan(
                            text:
                            'Everything you need to know about the city',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeightManager.medium,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 5.h,
                      child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 40.w,
                          decoration: BoxDecoration(

                            color: const Color(0xffF15A25),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Hotels - Tourist Attractions - Restaurants - Entertainment Venues',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeightManager.regular,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainView(),));
                    },
                    child: Container(
                      width: 300.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFf57c1e),
                            Color(0xFFfcb613),
                          ],
                        ),
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
                        "Let’s Go",
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
      ),
    );
  }
}
