import 'package:deal_ninja_spectrum/view/auth_ui/forgot_password_screen.dart';
import 'package:deal_ninja_spectrum/view/auth_ui/phone_validation.dart';
import 'package:deal_ninja_spectrum/view/auth_ui/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/email_pass_controller.dart';
import '../../controller/google_auth_controller.dart';
import '../../services/validations/validator.dart';
import '../main_page.dart';
import '../widgets/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Widget getTextField(
      {required String hint,
      required var icons,
      required var validator,
      required var controller}) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: icons,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Colors.transparent),
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
            height: 0.h,
          )),
    );
  }

  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final googleController = Get.put(GoogleAuthController());
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final emailPassController = Get.put(EmailPassController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
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
              'Login here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: const Color(0xFF1F41BB),
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
                height: 0.h,
              ),
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Welcome back you have \nbeen missed!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                height: 0.h,
              ),
            ),
          ),
          SizedBox(
            height: 53.h,
          ),
          Form(
            key: _formKey,
            child: Container(
              width: 357.w,
              height: 428.h,
              alignment: Alignment.center,
              child: Column(children: [
                SizedBox(
                  height: 26.h,
                ),
                getTextField(
                    hint: "Email",
                    icons: const Icon(Icons.email),
                    validator: (value) => Validator.validateEmail(
                          email: value,
                        ),
                    controller: _emailTextController),
                SizedBox(
                  height: 26.h,
                ),
                getTextField(
                    hint: "Password",
                    icons: const Icon(Icons.lock),
                    validator: (value) => Validator.validatePassword(
                          password: value,
                        ),
                    controller: _passwordTextController),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Get.off(const ForgotPasswordScreen(),
                          transition: Transition.leftToRightWithFade);
                    },
                    child: Text(
                      'Forgot your password?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: const Color(0xFF1F41BB),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        height: 0.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                    width: 357.w,
                    height: 50.h,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(9.r))),
                          backgroundColor: const MaterialStatePropertyAll(
                              Color(0xFF1F41BB))),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          try {
                            UserCredential? userCredential =
                                await emailPassController.signinUser(
                              _emailTextController.text,
                              _passwordTextController.text,
                            );
                            if (userCredential!.user!.emailVerified) {
                              final user = userCredential.user;
                              Get.off(() => const MainPage(),
                                  transition:
                                      Transition.leftToRightWithFade);
                            }
                          } catch (e) {
                            print(e);
                          } finally {
                            setState(() {
                              _loading = false;
                            });
                          }
                        }
                        // Get.off(const HomeScreen(), transition: Transition.leftToRightWithFade);
                      },
                      child: _loading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Sign in',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                height: 0.h,
                                fontFamily: 'Poppins',
                              ),
                            ),
                    )),
                SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  onTap: () {
                    Get.off(const SignUpScreen(),
                        transition: Transition.rightToLeftWithFade);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Create new account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF494949),
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0.h,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          SizedBox(
            height: 75.h,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Or continue with',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF494949),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                height: 0.h,
              ),
            ),
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
                  try {
                    googleController.signInWithGoogle().then((result) {
                      if (result != null) {
                        final user = googleController.user.value;
                        if (user != null) {
                          Get.off(() => const MainPage(),
                              transition: Transition.leftToRightWithFade);
                        }
                      }
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                child: SizedBox(
                  width: 60.w,
                  height: 44.h,
                  child: SvgPicture.asset(
                      'assets/images/flat-color-icons_google.svg'),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              GestureDetector(
                onTap: () {
                  Get.off(const MyPhone(),
                      transition: Transition.leftToRightWithFade);
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
      ]),
    );
  }
}
