import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_ninja_spectrum/view/widgets/checkout_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/add_product_controller.dart';
import '../../model/cart_model.dart';

class CartItemScreen extends StatefulWidget {
  const CartItemScreen({super.key});

  @override
  State<CartItemScreen> createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen> {
  num totalPriceFinal = 0;
  @override
  Widget build(BuildContext context) {
    final addFirebaseController = Get.put(AddFirebaseController());
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => Scaffold.of(context).openDrawer()),
        backgroundColor: const Color(0xFF1F41BB),
        title: Text(
          "Cart",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            height: 0.h,
            fontFamily: 'Poppins',
          ),
        ),
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
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0.w,
                  vertical: 10.h,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0.r),

                  ),
                  elevation: 4.0,
                  color: Colors.white,
                  child: Padding(
                    padding:  EdgeInsets.all(8.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          child: CachedNetworkImage(
                            imageUrl: cartProduct.productImages[0],
                            fit: BoxFit.contain,
                            width: 45.w,
                            placeholder: (context, url) => const ColoredBox(
                              color: Colors.white,
                              child:
                                  Center(child: CupertinoActivityIndicator()),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
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
                        IconButton(
                          onPressed: () async {
                            await addFirebaseController
                                .decrementCartItemQuantity(
                                    uId: user!.uid,
                                    productId: cartProduct.productId);
                          },
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Color(0xFFCF1919),
                          ),
                        ),
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
                        IconButton(
                          onPressed: () async {
                            await addFirebaseController
                                .incrementCartItemQuantity(
                                    uId: user!.uid,
                                    productId: cartProduct.productId);
                          },
                          icon: const Icon(Icons.add_circle,
                              color: Color(0xFF007C39)),
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
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF712B2B),
            borderRadius: BorderRadius.circular(15.r),
          ),
          padding: EdgeInsets.all(15.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FutureBuilder<num>(
                future:
                    addFirebaseController.calculatingTotalPrice(user!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While the future is still running, show a loading indicator or placeholder.
                    return const CupertinoActivityIndicator();
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
                        height: 0.h,
                      ),
                    );
                  }
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.r))),
                    backgroundColor:
                        const MaterialStatePropertyAll(Color(0xFF1F41BB))),
                onPressed: () {
                  Get.off(const CheckOutScreen(),transition: Transition.leftToRightWithFade);
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
            ],
          ),
        ),
      ),
    );
  }
}
