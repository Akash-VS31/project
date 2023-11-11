import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:deal_ninja_spectrum/view/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/add_product_controller.dart';
import '../../model/product-model.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductModel productModel;
  ProductDetailScreen({super.key, required this.productModel});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final addFirebaseController = Get.put(AddFirebaseController());
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
            onPressed: () {
              Get.off(() => const MainPage(),
                  transition: Transition.leftToRightWithFade);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: const Color(0xFF1F41BB),
      ),
      body: Column(children: [
        SizedBox(
          height: Get.height / 60.h,
        ),
        CarouselSlider(
          items: widget.productModel.productImages
              .map((imageUrls) => ClipRRect(
                    borderRadius: BorderRadius.circular(8.0.r),
                    child: CachedNetworkImage(
                      imageUrl: imageUrls,
                      fit: BoxFit.fill,
                      width: 150.h,
                      placeholder: (context, url) => const ColoredBox(
                        color: Colors.white,
                        child: Center(child: CupertinoActivityIndicator()),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
              scrollDirection: Axis.horizontal,
              autoPlay: true,
              aspectRatio: 2.5,
              viewportFraction: 1),
        ),
        Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0.r)),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.productModel.productName,
                          style: TextStyle(
                              color: const Color(0xFFCF1919),
                              fontFamily: 'Poppins',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800),
                        ),
                        IconButton(
                            onPressed: () async {
                              await addFirebaseController.addFavoriteItem(
                                  uId: user!.uid,
                                  productModel: widget.productModel);
                            },
                            icon: const Icon(Icons.favorite_border_outlined)),
                      ]),
                ),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      widget.productModel.isSale == true &&
                              widget.productModel.salePrice != ''
                          ? Text(
                              "₹ ${widget.productModel.salePrice}",
                              style: TextStyle(
                                  color: const Color(0xFF519B58),
                                  fontFamily: 'Poppins',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800),
                            )
                          : Text(
                              "₹${widget.productModel.fullPrice}",
                              style: TextStyle(
                                  color: const Color(0xFF519B58),
                                  fontFamily: 'Poppins',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800),
                            ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text("Category : ${widget.productModel.categoryName}",
                      style: TextStyle(
                          color: const Color(0xFF494949),
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.only(
                    top: 8.w, left: 8.w, right: 8.w, bottom: 180.w),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(widget.productModel.productDescription,
                      style: TextStyle(
                          color: const Color(0xFF494949),
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      child: Container(
                        width: Get.width / 2.9.w,
                        height: Get.height / 16.h,
                        decoration: BoxDecoration(
                            color: const Color(0xFF1F41BB),
                            borderRadius: BorderRadius.circular(20.0.r)),
                        child: TextButton(
                            onPressed: () async {
                              int phone = 919400377390;
                              var whatsappUrl = "whatsapp://send?phone=$phone";
                              var uri = Uri.parse(whatsappUrl);
                              await launchUrl(uri)
                                  ? launchUrl(uri)
                                  : print(
                                      "Open WhatsApp app link or show a snackbar with a notification that WhatsApp is not installed.");
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10.w,
                                ),
                                SvgPicture.asset(
                                  'assets/images/logos_whatsapp-icon.svg',
                                  width: 30.w,
                                  height: 30.h,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text("WhatsApp",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500)),
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 40.0.w,
                    ),
                    Material(
                      child: Container(
                        width: Get.width / 3.0.w,
                        height: Get.height / 16.h,
                        decoration: BoxDecoration(
                            color: const Color(0xFF1F41BB),
                            borderRadius: BorderRadius.circular(20.0.r)),
                        child: TextButton(
                            onPressed: () async {
                              await addFirebaseController.checkProductExistance(
                                  uId: user!.uid,
                                  productModel: widget.productModel);
                            },
                            child: Text("Add to cart",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500))),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        )
      ]),
    );
  }
}
