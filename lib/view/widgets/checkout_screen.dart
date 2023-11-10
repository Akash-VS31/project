import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_ninja_spectrum/services/upi_india/upi_india.dart';
import 'package:deal_ninja_spectrum/view/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/add_product_controller.dart';
import '../../model/cart_model.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final addFirebaseController = Get.put(AddFirebaseController());
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () =>
                Get.off(MainPage(), transition: Transition.leftToRightWithFade),
            icon: Icon(CupertinoIcons.back)),
        backgroundColor: const Color(0xFF1F41BB),
        title: Text("Checkout"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(user!.uid) // Use the current user's UID
            .collection('cartOrders')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Your cart is empty.'));
          }
          final cartItems = snapshot.data!.docs;

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              final cartProduct =
                  CartModel.fromMap(cartItem.data() as Map<String, dynamic>);
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: CachedNetworkImage(
                          imageUrl: cartProduct.productImages[0],
                          fit: BoxFit.contain,
                          width: 45.w,
                          placeholder: (context, url) => ColoredBox(
                            color: Colors.white,
                            child: Center(child: CupertinoActivityIndicator()),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Flexible(
                          child: Text(
                        cartProduct.productName,
                        style: TextStyle(
                          color: const Color(0xFF494949),
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0.h,
                        ),
                      )),
                      Text(
                        '${cartProduct.productQuantity}',
                        style: TextStyle(
                          color: const Color(0xFF494949),
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0.h,
                        ),
                      ),
                      Flexible(
                          child: Text(
                        ' ₹${cartProduct.productTotalPrice}',
                        style: TextStyle(
                          color: const Color(0xFF47002B),
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0.h,
                        ),
                      )),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF7B4FB6),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FutureBuilder<num>(
                future:
                addFirebaseController.calculatingTotalPrice(user!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While the future is still running, show a loading indicator or placeholder.
                    return CupertinoActivityIndicator();
                  } else if (snapshot.hasError) {
                    // If there was an error, you can display an error message.
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // When the future is complete, display the result using snapshot.data.
                    return Text(
                      ' Total : ₹ ${snapshot.data!.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    );
                  }
                },
              ),
              Row(children: [
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.r))),
                      backgroundColor:
                      const MaterialStatePropertyAll(Color(0xFFC10000))),
                  onPressed: () {
                    Get.off(MainPage(),transition: Transition.leftToRightWithFade);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0.h,
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.r))),
                      backgroundColor:
                      const MaterialStatePropertyAll( Color(0xFF1F41BB))),
                  onPressed: () {
                    Get.off(UpiScreen(),transition: Transition.leftToRightWithFade);
                  },
                  child: Text(
                    'Checkout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0.h,
                    ),
                  ),
                ),
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
