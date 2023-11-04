import 'package:deal_ninja_spectrum/view/auth_ui/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  Widget getTextField({required String hint, required var icons}) {
    return TextFormField(
      decoration: InputDecoration(
          prefixIcon: icons,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          filled: true,
          fillColor: const Color(0xFFF1F4FF),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.black54,
            fontFamily: 'Poppins',
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            height: 0,
          )),
    );
  }

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
              SizedBox(
                height: 97.h,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Forgot password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: const Color(0xFF1F41BB),
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Please enter your email address.You will recive \na link to create a new password via email.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(
                height: 53.h,
              ),
              Container(
                width: 357.w,
                height: 428.h,
                alignment: Alignment.center,
                child: Column(children: [
                  SizedBox(
                    height: 26.h,
                  ),
                  getTextField(hint: "Email", icons: const Icon(Icons.email)),
                  SizedBox(
                    height: 25.h,
                  ),
                  SizedBox(
                    width: 357.w,
                    height: 50.h,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9.r))),
                          backgroundColor: const MaterialStatePropertyAll(
                              Color(0xFF1F41BB))),
                      onPressed: () {
                        Get.off(const WelcomeScreen(), transition: Transition.leftToRightWithFade);
                      },
                      child: Text(
                        'Rest password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ])),
    );
  }
}
