// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../auth_ui/welcome_screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  User? user = FirebaseAuth.instance.currentUser;
  final currentUser = FirebaseAuth.instance;
  late String userName = '';
  late String userEmail;
  late String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0.r),
          bottomRight: Radius.circular(20.0.r),
        ),
      ),
      backgroundColor: const Color(0xFF981206),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .where("uId", isEqualTo: currentUser.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: SizedBox(
                      width: 25.w,
                      height: 25.h,
                      child: CircularProgressIndicator())); // Loading state
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.h),
                    child: ListTile(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Get.off(() => WelcomeScreen());
                      },
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text(
                        "Logout",
                        style: TextStyle(
                          color: Color(0xFFFBF5F4),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      leading: const Icon(
                        Icons.logout,
                        color: Color(0xFFFBF5F4),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward,
                        color: Color(0xFFFBF5F4),
                      ),
                    ),
                  ),
                  Text("No data found")
                ],
              ); // No data found
            }
            final userData =
                snapshot.data!.docs.first.data() as Map<String, dynamic>;
            userName = userData['username'] as String;
            userEmail = userData['email'] as String;
            imageUrl = userData['userImg'
                ''] as String;
            return Wrap(
              runSpacing: 10,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.0.w, vertical: 20.0.h),
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Text(
                      userName,
                      style: TextStyle(
                          color: Color(0xFFFBF5F4),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                    ),
                    subtitle: Text(
                      userEmail,
                      style: TextStyle(
                        color: Color(0xFFFBF5F4),
                        fontSize: 10.sp,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: 22.0.r,
                      backgroundColor: Color(0xFFbf1b08),
                      backgroundImage: imageUrl.isNotEmpty
                          ? Image.network(imageUrl).image
                          : Image.asset('asset/images/google_icon.png').image,
                    ),
                  ),
                ),
                Divider(
                  indent: 10.0,
                  endIndent: 10.0,
                  thickness: 1.5,
                  color: Colors.grey,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Text(
                      "Home",
                      style: TextStyle(
                        color: Color(0xFFFBF5F4),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    leading: Icon(
                      Icons.home,
                      color: Color(0xFFFBF5F4),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Color(0xFFFBF5F4),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Text(
                      "Products",
                      style: TextStyle(
                        color: Color(0xFFFBF5F4),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    leading: Icon(
                      Icons.production_quantity_limits,
                      color: Color(0xFFFBF5F4),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Color(0xFFFBF5F4),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.h),
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Text(
                      "Orders",
                      style: TextStyle(
                        color: Color(0xFFFBF5F4),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    leading: Icon(
                      Icons.shopping_bag,
                      color: Color(0xFFFBF5F4),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Color(0xFFFBF5F4),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.h),
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Text(
                      "Contact",
                      style: TextStyle(
                        color: Color(0xFFFBF5F4),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    leading: Icon(
                      Icons.help,
                      color: Color(0xFFFBF5F4),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Color(0xFFFBF5F4),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.h),
                  child: ListTile(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.off(() => WelcomeScreen());
                    },
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        color: Color(0xFFFBF5F4),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    leading: const Icon(
                      Icons.logout,
                      color: Color(0xFFFBF5F4),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward,
                      color: Color(0xFFFBF5F4),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
