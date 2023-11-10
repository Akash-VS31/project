import 'package:deal_ninja_spectrum/view/auth_ui/sign_in_screen.dart';
import 'package:deal_ninja_spectrum/view/auth_ui/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
        ),
        SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
              ),
              SizedBox(
                height: 50.h,
              ),
              Container(
                alignment: Alignment.center,
                child: SvgPicture.asset('assets/images/welcome image.svg'),
              ),
              SizedBox(
                height: 47.h,
              ),
              SizedBox(
                width: 343.w,
                child: Text(
                  'Discover Your \nDream Deal here',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1F41BB),
                    fontFamily: 'Poppins',
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(
                height: 23.h,
              ),
              SizedBox(
                width: 343.w,
                child: Text(
                  'Explore all the existing job roles based on your \ninterest and study major',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 0.h,
                  ),
                ),
              ),
              SizedBox(
                height: 88.h,
              ),
              Container(
                alignment: Alignment.center,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    width: 160.w,
                    height: 50.h,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9.r))),
                          backgroundColor: const MaterialStatePropertyAll(
                              Color(0xFF1F41BB))),
                      onPressed: () {
                        Get.off(() => const SignInScreen(),
                            transition: Transition.leftToRightWithFade);
                      },
                      child: Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          height: 0.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  SizedBox(
                    width: 160.w,
                    height: 50.h,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              const Color(0xFF1F41BB)),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9.r))),
                          backgroundColor: const MaterialStatePropertyAll(
                              Color(0xFF595959))),
                      onPressed: () {
                        Get.off(() => const SignUpScreen(),
                            transition: Transition.leftToRightWithFade);
                      },
                      child: Text(
                        'Register',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          height: 0.h,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: 88.h,
              )
            ],
          ),
        ),
      ])),
    );
  }
}
