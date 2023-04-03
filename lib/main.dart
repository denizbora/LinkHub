import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get/get.dart';
import 'package:link_project/constants/constants.dart';
import 'package:link_project/controllers/app_controller.dart';
import 'package:link_project/firebase_options.dart';
import 'package:link_project/generators/material_color_generator.dart';
import 'package:link_project/helpers/authentication_helper.dart';
import 'package:link_project/screens/LinkPage/link_page.dart';
import 'package:link_project/screens/LinkPage/link_page_app_controller.dart';
import 'package:link_project/screens/LinkPage/link_page_cotroller.dart';
import 'package:link_project/screens/login_page.dart';
import 'package:link_project/screens/user_page.dart';
import 'controllers/user_controller.dart';

Future<void> main() async {
  final UserController controller = Get.put(UserController());
  Get.put(AppController());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (AuthenticationHelper().checkLogin()) {
    controller.changeUsr();
    controller.getFields();
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    usePathUrlStrategy();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          primarySwatch:
              materialColorGenerator(Constants().bottomNavSelectedColor)),
      routes: {
        '/': (context) => AuthenticationHelper().checkLogin()
            ? const UserPage()
            : LoginPage(),
        '/UserPage': (context) => AuthenticationHelper().checkLogin()
            ? const UserPage()
            : LoginPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name!.substring(1, 6) == 'pages') {
          final username = settings.name!.split('=')[1];
          Get.put(LinkPageAppController());
          Get.put(LinkPageController(username));
          return MaterialPageRoute(
            builder: (context) => LinkPage(username: username),
          );
        }

        return null;
      },
      initialRoute: '/',
      title: 'LinkHub',
      debugShowCheckedModeBanner: false,
    );
  }
}
