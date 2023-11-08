import 'package:deal_ninja_spectrum/view/auth_ui/welcome_screen.dart';
import 'package:deal_ninja_spectrum/view/widgets/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/email_validation_controller.dart';

class EmailValidationScreen extends StatefulWidget {
  final User user;

  const EmailValidationScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<EmailValidationScreen> createState() => _EmailValidationScreenState();
}

class _EmailValidationScreenState extends State<EmailValidationScreen> {
  bool _isSendingVerification = false;
  bool _isSigningOut = false;
  final emailValidationController=Get.put(EmailValidationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Text(
                    'Verify your email address',
                    style: TextStyle(
                      fontFamily: 'Poppins-SemiBold',
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: Color(0xFF1F41BB),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Name: ${widget.user.displayName}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Poppins-Regular',
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Email: ${widget.user.email}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Poppins-Regular',
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                widget.user.emailVerified
                    ? Center(
                  child: Text(
                    'Email is verified',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w400,
                      color: Colors.green,
                    ),
                  ),
                )
                    : Center(
                  child: Text(
                    'Email is not verified',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w400,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                _isSendingVerification
                    ? Center(child: CircularProgressIndicator())
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFF1F41BB)),
                        ),
                        onPressed: () async {
                          setState(() {
                            _isSendingVerification = true;
                          });
                          await emailValidationController.sendingEmailVerification(widget.user);
                          setState(() {
                            _isSendingVerification = false;
                          });
                        },
                        child: Text('Verify'),
                      ),
                    ),
                    SizedBox(
                     width: 30.w,
                    ),
                    TextButton.icon(     // <-- TextButton
                      onPressed: () async {
                        try {
                          User? user = await emailValidationController.refreshEmail(widget.user);
                          if (user != null && user.emailVerified) {
                            Get.snackbar('Success : ', 'Email has been verified successfully');
                            Get.off(HomeScreen());
                          }else{
                            Get.snackbar('Failed : ', 'Email has been not verified check your mail');
                          }
                        } catch (e) {}
                      },
                      icon:  Icon(Icons.refresh,size: 24.0,color: Color(0xFF1F41BB),),
                      label: Text('Check', style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _isSigningOut
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFF1F41BB)),
                    ),
                    onPressed: () async {
                      setState(() {
                        _isSigningOut = true;
                      });
                      await FirebaseAuth.instance.signOut();
                      setState(() {
                        _isSigningOut = false;
                        Get.off(WelcomeScreen());
                      });
                    },
                    child: Text('Sign out'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}