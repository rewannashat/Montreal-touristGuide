import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:montreal_tourist/presentation/screens/Home/Main-viewModel/main_cubit.dart';
import 'package:montreal_tourist/presentation/screens/Logins/login-view/splash-view.dart';
import 'package:montreal_tourist/presentation/screens/Logins/login_viewModel/login_cubit.dart';

import 'domian/Lang/app_locale.dart';
import 'domian/bloc_observer.dart';
import 'domian/local/sharedPref.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'domian/ntwork_check_view.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  await ScreenUtil.ensureScreenSize();
  await SharedPreferencesHelper.init();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => GlobalLoaderOverlay(
        useDefaultLoading: true,
        child: NetworkWrapper(
          child: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(360, 690), // Use your design size
      minTextAdapt: true,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => MainCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        builder: DevicePreview.appBuilder,
        home: SplashView(),
      ),
    );
  }
}
