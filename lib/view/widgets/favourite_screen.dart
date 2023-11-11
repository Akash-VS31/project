import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/add_product_controller.dart';
import '../../model/favorite_model.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final addFirebaseController = Get.put(AddFirebaseController());
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => Scaffold.of(context).openDrawer()
        ),
        backgroundColor: const Color(0xFF1F41BB),
        title: Text("Favourite",style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          height: 0.h,
          fontFamily: 'Poppins',
        ),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('favorite')
            .doc(user!.uid) // Use the current user's UID
            .collection('favoriteItems')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Favourite screen is empty.'));
          }
          final favoriteItem = snapshot.data!.docs;

          return ListView.builder(
            itemCount: favoriteItem.length,
            itemBuilder: (context, index) {
              final cartItem = favoriteItem[index];
              final cartProduct =
              FavoriteModel.fromMap(cartItem.data() as Map<String, dynamic>);
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
                    padding: EdgeInsets.all(8.0.w),
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
                                .deleteFavoriteItem(
                                uId: user!.uid,
                                productId: cartProduct.productId);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Color(0xFFCF1919),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
