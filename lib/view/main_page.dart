import 'package:deal_ninja_spectrum/view/widgets/cart_screen.dart';
import 'package:deal_ninja_spectrum/view/widgets/custom-drawer-widget.dart';
import 'package:deal_ninja_spectrum/view/widgets/home_screen.dart';
import 'package:deal_ninja_spectrum/view/widgets/favourite_screen.dart';
import 'package:deal_ninja_spectrum/view/widgets/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static List<Widget> _pages = <Widget>[
    HomeScreen(),
    FavouriteScreen(),
    CartItemScreen(),
    SettingsScreen()
  ];
  int _currentSelectedIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _currentSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: _pages[_currentSelectedIndex],
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
            icon: Icon(Icons.favorite),
            label: "Favorite",
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
    );
  }
}
