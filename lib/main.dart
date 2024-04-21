import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_export.dart'; // Ensure this file properly handles exports
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import '../presentation/no_go_page/no_go_page.dart';
import '../presentation/go_for_it_page/go_for_it_page.dart';
// import 'package:sizer/sizer.dart' as sizerUtil;

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // Assuming ThemeHelper is correctly implemented to manage themes.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
          onGenerateRoute: (settings) {
            if (settings.name == '/go_for_it_page' || settings.name == AppRoutes.noGoPage) {
              final args = settings.arguments as Map<String, dynamic>;
    switch (settings.name) {
      case '/go_for_it_page':
        // Ensure args is not null and has the required data
        if (args != null && args.containsKey('productName')) {
          return MaterialPageRoute(
            builder: (context) => GoForItPage(productName: args['productName'])
          );
        }
        break; // Break is necessary to exit the switch case

      case '/no_go_page':
        if (args != null && args.containsKey('productName')) {
          return MaterialPageRoute(
            builder: (context) => NoGoPage(productName: args['productName'])
          );
        }
        break;

      default:
        // Handling unexpected routes
        return MaterialPageRoute(builder: (context) => NotFoundPage());
    }
      }
            return null;
          },
        );
      },
    );
  }
}

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("404 Not Found")),
      body: Center(child: Text("The page you are looking for doesn't exist.")),
    );
  }
}

