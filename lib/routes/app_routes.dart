import 'package:flutter/material.dart';
import 'package:likhith_s_application2/presentation/search_page_screen/search_page_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/scanner_page_screen/scanner_page_screen.dart';
import '../presentation/choices_page_screen/choices_page_screen.dart';
import '../presentation/health_info_page_screen/health_info_page_screen.dart';
import '../presentation/profile_page_screen/profile_page_screen.dart';
import '../presentation/no_go_page/no_go_page.dart';
import '../presentation/go_for_it_page/go_for_it_page.dart';
import '../presentation/scanner_page_screen/scan_page.dart';
class AppRoutes {
  static const String loginScreen = '/login_screen';

  static const String scannerPageScreen = '/scanner_page_screen';

  static const String choicesPageScreen = '/choices_page_screen';

  static const String healthInfoPageScreen = '/health_info_page_screen';

  static const String profilePageScreen = '/profile_page_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String noGoPage = '/no_go_page';

  static const String goForItPage = '/go_for_it_page';

  static const String searchPageScreen = '/search_page_screen';

  static const String scanPage = '/scan_page'; 


  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginScreen(),
    scannerPageScreen: (context) => ScannerPageScreen(),
    choicesPageScreen: (context) => ChoicesPageScreen(),
    healthInfoPageScreen: (context) => HealthInfoPageScreen(),
    profilePageScreen: (context) => ProfilePageScreen(),
    noGoPage: (context) => NoGoPage(),
    searchPageScreen:(context) => SearchPageScreen(),
    goForItPage: (context) => GoForItPage(),
    scanPage: (context) => CameraApp(),

  };
}
