import 'package:deal_ninja_spectrum/view/auth_ui/welcome_screen.dart';
import 'package:deal_ninja_spectrum/view/widgets/cart_screen/cart_screen.dart';
import 'package:deal_ninja_spectrum/view/widgets/notification_screen.dart';
import 'package:deal_ninja_spectrum/view/widgets/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          bottom: PreferredSize(
            preferredSize:
                Size.fromHeight(85.0.h), // Adjust the preferred height as needed
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: getTextField(hint: "search", icons: const Icon(Icons.search)),
            ),
          ),
          title: Text(
            "Hi, Vineeth Venu",
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
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.location_on),
                  Text(
                    "Kochi",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  )
                ]),
            SizedBox(
              width: 20.w,
            ),
          ]),
      body: SafeArea(
          child: Stack(children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
        ),
        SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Text("Home"),
              ElevatedButton(
                  onPressed: () {
                    Get.off(const WelcomeScreen(),
                        transition: Transition.leftToRightWithFade);
                  },
                  child: Text("back"))
            ],
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
            backgroundColor:  Color(0xFFF4EFEF),
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            backgroundColor:  Color(0xFFF4EFEF),
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            backgroundColor:  Color(0xFFF4EFEF),
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            backgroundColor:  Color(0xFFF4EFEF),
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
