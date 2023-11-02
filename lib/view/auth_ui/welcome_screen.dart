import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
                child: Text('Discover Your \nDream Deal here',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFF1F41BB),
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    )),
              ),
              SizedBox(
                height: 23.h,
              ),
              SizedBox(
                width: 343.w,
                child: Text(
                    'Explore all the existing job roles based on your \ninterest and study major',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    )),
              ),
              SizedBox(
                height: 88.h,
              ),
              Container(
                alignment: Alignment.center,
                child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
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
                      onPressed: () {},
                      child: Text('Login',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          )),
                    ),
                  ),
                  SizedBox(width: 20.w,),
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
                      onPressed: () {},
                      child: Text('Register',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          )),
                    ),
                  )
                ]),
              ),
              SizedBox(height: 88.h,)
            ],
          ),
        ),
      ])),
    );
  }
}
