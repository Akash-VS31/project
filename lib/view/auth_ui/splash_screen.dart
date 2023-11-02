import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35.h,
              ),
              Center(
                child: SizedBox(
                    height: 47.h,
                    width: 250.w,
                    child: Image.asset('assets/images/deal-ninja-logo.png')),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30.h,
              ),
              const CircularProgressIndicator(
                color: Color(0xFF1F41BB),
              ),
              SizedBox(

              )
            ],
          ),
        ),
      ])),
    );
  }
}
