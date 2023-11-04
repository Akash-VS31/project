import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
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
      child: Wrap(
        runSpacing: 10,
        children: [
          Padding(
            padding:
             EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 20.0.h),
            child: ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              title: Text(
                "Waris",
                style: TextStyle(color: Color(0xFFFBF5F4),  fontFamily: 'Poppins',),
              ),
              subtitle: Text(
                "Version 1.0.1",
                style: TextStyle(color: Color(0xFFFBF5F4),  fontFamily: 'Poppins',),
              ),
              leading: CircleAvatar(
                radius: 22.0.r,
                backgroundColor:  Color(0xFFbf1b08),
                child: Text(
                  "W",
                  style: TextStyle(color: Color(0xFFFBF5F4),  fontFamily: 'Poppins',),
                ),
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
                style: TextStyle(color: Color(0xFFFBF5F4),  fontFamily: 'Poppins',),
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
                style: TextStyle(color: Color(0xFFFBF5F4),  fontFamily: 'Poppins',),
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
                style: TextStyle(color:Color(0xFFFBF5F4),  fontFamily: 'Poppins',),
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
                style: TextStyle(color: Color(0xFFFBF5F4),  fontFamily: 'Poppins',),
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

              },
              titleAlignment: ListTileTitleAlignment.center,
              title: Text(
                "Logout",
                style: TextStyle(color: Color(0xFFFBF5F4),  fontFamily: 'Poppins',),
              ),
              leading: const Icon(
                Icons.logout,
                color: Color(0xFFFBF5F4),
              ),
              trailing: const Icon(
                Icons.arrow_forward,
                color:Color(0xFFFBF5F4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}