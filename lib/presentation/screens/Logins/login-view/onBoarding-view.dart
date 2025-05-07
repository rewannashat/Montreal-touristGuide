import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/font-manager.dart';
import '../../Home/Main-view/main_view.dart';
import '../login-model/onBorading_model.dart';
import '../login_viewModel/login_cubit.dart';
import '../login_viewModel/login_states.dart';
import 'onBoard-view.dart';


class OnBoardingView extends StatelessWidget {
  OnBoardingView({super.key});

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          final cubit = LoginCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFa36bbf),
                      Color(0xFFb876c5),
                      Color(0xFFc071c3),
                      Color(0xFFb767be),


                    ],
                  ),
                ),
               child: PageView.builder(
                 controller: pageController,
                 itemCount: onboardingPages.length,
                 onPageChanged: cubit.changePage,
                 itemBuilder: (context, index) {
                   final page = onboardingPages[index];
                   return Padding(
                     padding: const EdgeInsets.all(20),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         SizedBox(height: 40.h),
                         Expanded(
                           flex: 1,
                            child: Column(
                          children: [
                            Image.asset(
                              page.image,
                              height: 300,
                            ),
                            SizedBox(height: 30.h),
                            Text(
                              page.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeightManager.light,
                                color: index == 1 ? Color(0xffFFC421) : Colors.white,
                                fontFamily: 'InriaSans',
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              page.subtitle,
                              textAlign: TextAlign.center,
                              style:  TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeightManager.light,
                                color: Colors.white,
                                fontFamily: 'InriaSans',
                              ),
                            ),
                          ],
                        )),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: List.generate(
                             onboardingPages.length,
                                 (index) => Container(
                               margin: const EdgeInsets.symmetric(horizontal: 4),
                               width: cubit.currentPage == index ? 12.w : 6.w,
                               height: 6.h,
                               decoration: BoxDecoration(
                                 color: cubit.currentPage == index
                                     ? Color(0xffFFC421)
                                     : Colors.grey,
                                 borderRadius: BorderRadius.circular(3),
                               ),
                             ),
                           ),
                         ),
                         SizedBox(height: 50.h),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               TextButton(
                                 onPressed: () {
                                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainView(),));
                                 },
                                 child: Text("Skip" , style:  TextStyle(
                                   fontSize: 15.sp,
                                   fontWeight: FontWeightManager.light,
                                   color: Colors.black,
                                   fontFamily: 'InriaSans',
                                 ), ),
                               ),
                               InkWell(
                                 onTap: () {
                                   if (cubit.currentPage == onboardingPages.length - 1) {
                                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoardView(),));
                                   } else {
                                     cubit.nextPage(onboardingPages.length);
                                     pageController.animateToPage(
                                       cubit.currentPage,
                                       duration: const Duration(milliseconds: 300),
                                       curve: Curves.easeInOut,
                                     );
                                   }
                                 },
                                 borderRadius: BorderRadius.circular(50),
                                 child: Container(
                                   width: 50,
                                   height: 50,
                                   decoration: BoxDecoration(
                                     shape: BoxShape.circle,
                                     color:  Color(0xffFFC421),
                                   ),
                                   child: const Icon(
                                     Icons.arrow_forward,
                                     color: Colors.black,
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                         SizedBox(height: 20.h),


                       ],
                     ),
                   );
                 },
               ),

              ),
            ),
          );
        },
      ),
    );
  }
}
