import 'package:deal_ninja_spectrum/view/auth_ui/forgot_password_screen.dart';
import 'package:deal_ninja_spectrum/view/auth_ui/sign_in_screen.dart';
import 'package:deal_ninja_spectrum/view/auth_ui/sign_up_screen.dart';
import 'package:deal_ninja_spectrum/view/auth_ui/splash_screen.dart';
import 'package:deal_ninja_spectrum/view/auth_ui/welcome_screen.dart';
import 'package:deal_ninja_spectrum/view/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
