import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_ninja_spectrum/view/auth_ui/welcome_screen.dart';
import 'package:deal_ninja_spectrum/view/widgets/all-products-widget.dart';
import 'package:deal_ninja_spectrum/view/widgets/banner-widget.dart';
import 'package:deal_ninja_spectrum/view/widgets/cart_screen.dart';
import 'package:deal_ninja_spectrum/view/widgets/category-widget.dart';
import 'package:deal_ninja_spectrum/view/widgets/custom-drawer-widget.dart';
import 'package:deal_ninja_spectrum/view/widgets/favourite_screen.dart';
import 'package:deal_ninja_spectrum/view/widgets/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


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
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
  User? user = FirebaseAuth.instance.currentUser;
  final currentUser = FirebaseAuth.instance;
  late String userName = '';
  late String userEmail;
  late String imageUrl;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading:  IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer()
          ),
            primary: false,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(
                  85.0.h), // Adjust the preferred height as needed
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: getTextField(
                    hint: "search", icons: const Icon(Icons.search)),
              ),
            ),
            title: Text(
              "Hi, $userName",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            backgroundColor: const Color(0xFF1F41BB),
            elevation: 0,
           ),
        body: SafeArea(
            child: Stack(children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trending deals',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF494949),
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  const BannerWidget(),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    'All category',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF494949),
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  SizedBox(
                      width: 349.w, height: 115.h, child: CategoriesWidget()),
                  Text(
                    'All deals',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF494949),
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  const AllProductsWidget()
                ],
              ),
            ),
          ),
        ])),
      ),
    );
  }
}
