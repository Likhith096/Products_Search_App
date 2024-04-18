import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_export.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  ThemeHelper().changeTheme('primary');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
);
  runApp(MyApp());
}

  

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'likhith_s_application2',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.loginScreen,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
