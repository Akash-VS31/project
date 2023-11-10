import 'dart:async';

import 'package:deal_ninja_spectrum/view/auth_ui/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/get-user-data-controller.dart';
import '../main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      logInCheck(context);
    });
  }

  Future<void> logInCheck(BuildContext context) async {
    if (user != null) {
      final GetUserDataController getUserDataController =
          Get.put(GetUserDataController());
      Get.offAll(() => const MainPage(),
          transition: Transition.leftToRightWithFade);
    } else {
      Get.to(() => const WelcomeScreen(),
          transition: Transition.leftToRightWithFade);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: Get.width * 0.5.w,
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/deal-ninja-logo.png',
                      width: 220.w),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30.0.h),
                width: Get.width.w,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Color(0xFF1F41BB),
                ),
              )
            ],
          ),
        ));
  }
}
