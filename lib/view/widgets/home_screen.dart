import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_ninja_spectrum/view/widgets/all-products-widget.dart';
import 'package:deal_ninja_spectrum/view/widgets/banner-widget.dart';
import 'package:deal_ninja_spectrum/view/widgets/category-widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getTextField({
    required String hint,
    required var icons,
    required var controller,
    required Function(String) onChanged,
  }) {
    return TextFormField(
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
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
  late String userName = '';
  late String imageUrl;
  late String userEmail;
  List searchResult = [];
  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('products')
        .where('productId', isEqualTo: query)
        .get();

    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  final _appbarTextController = TextEditingController();
  bool _isClicked = false;
  User? user = FirebaseAuth.instance.currentUser;
  final currentUser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => Scaffold.of(context).openDrawer()),
        primary: false,
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(85.0.h), // Adjust the preferred height as needed
          child: Padding(
            padding: EdgeInsets.all(13.0.w),
            child: getTextField(
                hint: "search",
                icons: Icon(Icons.search),
                controller: _appbarTextController,
                onChanged: (query) {
                  setState(() {
                    _isClicked = !_isClicked;
                    searchFromFirebase(query);
                  });
                  print(searchResult);
                }),
          ),
        ),
        title: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where("uId", isEqualTo: currentUser.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return Center(
                    child:
                    const CupertinoActivityIndicator()); // Loading state
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Text("No data found");
                // No data found
              }
              final userData = snapshot.data!.docs.first.data()
              as Map<String, dynamic>;
              userName = userData['username'] as String;
              imageUrl = userData['userImg'
                  ''] as String;
              userEmail = userData['email'] as String;
              return Container(child: Text('hi, $userName',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    height: 0.h,
                    fontFamily: 'Poppins',
                  )),);
            }),
        backgroundColor: const Color(0xFF1F41BB),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _isClicked
                  ? SizedBox(
                      height: Get.height,
                      child: Container(
                        color: Colors.teal,
                        child: ListView.builder(
                          itemCount: searchResult.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(searchResult[index]['productName']),
                              subtitle: Text(searchResult[index]['fullPrice']),
                            );
                          },
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              Text(
                'Trending deals',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF494949),
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0.h,
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
                  height: 0.h,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              SizedBox(
                  width: 349.w, height: 115.h, child: const CategoriesWidget()),
              Text(
                'All deals',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF494949),
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0.h,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              const AllProductsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
