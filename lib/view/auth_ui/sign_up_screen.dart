import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        filled: true,
        fillColor: const Color(0xFFF1F4FF),
        hintText: hint,
      ),
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
                child: Text('Create Account',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFF1F41BB),
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    )),
              ),
              SizedBox(
                height: 6.h,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                    'Create an account so you can explore all \nthe existing jobs',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    )),
              ),
              SizedBox(
                height: 53.h,
              ),
              Container(
                width: 357.w,
                height: 428.h,
                alignment: Alignment.center,
                child: Column(children: [
                  getTextField(
                      hint: "Name", icons: const Icon(Icons.person_outline)),
                  SizedBox(
                    height: 26.h,
                  ),
                  getTextField(hint: "Email", icons: const Icon(Icons.email)),
                  SizedBox(
                    height: 26.h,
                  ),
                  getTextField(hint: "Password", icons: const Icon(Icons.lock)),
                  SizedBox(
                    height: 53.h,
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
                      onPressed: () {},
                      child: Text('Sign up',
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
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Already have an account',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0xFF494949),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          )),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 75.h,
              ),
              Container(
                alignment: Alignment.center,
                child: Text('Or continue with',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFF494949),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    )),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 200.w,
                height: 44.h,
                alignment: Alignment.center,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      GestureDetector(
                        onTap: () {
                          print("clicked");
                        },
                        child: SizedBox(
                          width: 60.w,
                          height: 44.h,
                          child: SvgPicture.asset(
                              'assets/images/flat-color-icons_google.svg'),
                        ),
                      ),
                      SizedBox(width: 20.w,),
                      GestureDetector(
                        onTap: () {
                          print("clicked");
                        },
                        child: SizedBox(
                          width: 60.w,
                          height: 44.h,
                          child: SvgPicture.asset(
                              'assets/images/ic_sharp-local-phone.svg'),
                        ),
                      )

                    ]),
              ),
              SizedBox(
                height: 90.h,
              )
            ],
          ),
        ),
      ])),
    );
  }
}
