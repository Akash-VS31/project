import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_ninja_spectrum/view/auth_ui/welcome_screen.dart';
import 'package:deal_ninja_spectrum/view/widgets/all-products-widget.dart';
import 'package:deal_ninja_spectrum/view/widgets/banner-widget.dart';
import 'package:deal_ninja_spectrum/view/widgets/cart_screen/cart_screen.dart';
import 'package:deal_ninja_spectrum/view/widgets/category-widget.dart';
import 'package:deal_ninja_spectrum/view/widgets/notification_screen.dart';
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
  static List<Widget> _pages = <Widget>[
    HomeScreen(),
    NotificationScreen(),
    CartScreen(),
    SettingsScreen()
  ];
  int _currentSelectedIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _currentSelectedIndex = index;
    });
  }

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
        drawer: Drawer(
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
                  return Column(children: [
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
                  ],); // No data found
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
                              : Image.asset('asset/images/google_icon.png')
                                  .image,
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
        ),
        appBar: AppBar(
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
            actions: [
              IconButton(onPressed: () {
                Get.to(CartScreen());
              }, icon: Icon(CupertinoIcons.cart))
            ]),
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
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color(0xFF1F41BB),
          selectedLabelStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.sp,
          ),
          unselectedItemColor: Colors.black54,
          currentIndex: _currentSelectedIndex,
          onTap: _onTabTapped,
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Color(0xFFF4EFEF),
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xFFF4EFEF),
              icon: Icon(Icons.notifications),
              label: "Notifications",
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xFFF4EFEF),
              icon: Icon(Icons.shopping_cart),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xFFF4EFEF),
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
