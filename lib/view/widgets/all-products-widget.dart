import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_ninja_spectrum/view/user_panel/product_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/add_product_controller.dart';
import '../../model/product-model.dart';

class AllProductsWidget extends StatefulWidget {
  const AllProductsWidget({super.key});

  @override
  State<AllProductsWidget> createState() => _AllProductsWidgetState();
}

class _AllProductsWidgetState extends State<AllProductsWidget> {
  final addFirebaseController = Get.put(AddFirebaseController());
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('products')
          .where('isSale', isEqualTo: false)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: Get.height / 5.h,
            child: const Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No products found!"),
          );
        }

        if (snapshot.data != null) {
          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .78,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final productData = snapshot.data!.docs[index];
              ProductModel productModel = ProductModel(
                productId: productData['productId'],
                categoryId: productData['categoryId'],
                productName: productData['productName'],
                categoryName: productData['categoryName'],
                salePrice: productData['salePrice'],
                fullPrice: productData['fullPrice'],
                productImages: productData['productImages'],
                deliveryTime: productData['deliveryTime'],
                isSale: productData['isSale'],
                productDescription: productData['productDescription'],
                createdAt: productData['createdAt'],
                updatedAt: productData['updatedAt'],
              );
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black26,
                      width: 2.0.w,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.5),
                          offset: const Offset(3, 2),
                          blurRadius: 7.r)
                    ]),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.off(
                            ProductDetailScreen(productModel: productModel));
                      },
                      child: SizedBox(
                        width: 150.w,
                        height: 150.h,
                        child: Padding(
                          padding: EdgeInsets.all(13.0.w),
                          child: Image.network(
                            productModel.productImages[0],
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        productModel.productName,
                        style: TextStyle(
                            color: const Color(0xFF505050),
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 13.0.w),
                          child: Flexible(
                            child: Text(
                              ' ₹ ${productModel.fullPrice}',
                              style: TextStyle(
                                  color: const Color(0xFFCF1919),
                                  fontFamily: 'Poppins',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: CircleAvatar(
                            backgroundColor: const Color(0xFF660018),
                            child: IconButton(
                                icon: const Icon(Icons.add_shopping_cart,
                                    color: Colors.white),
                                onPressed: () async {
                                  await addFirebaseController
                                      .checkProductExistance(
                                          uId: user!.uid,
                                          productModel: productModel);
                                }),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }

        return Container();
      },
    );
  }
}
