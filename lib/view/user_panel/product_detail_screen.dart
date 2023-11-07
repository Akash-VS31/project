import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_ninja_spectrum/view/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../model/cart_model.dart';
import '../../model/product-model.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductModel productModel;
  ProductDetailScreen({super.key, required this.productModel});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: GestureDetector(
            onTap: () {
              Get.off(HomeScreen());
            },
            child: Icon(CupertinoIcons.back)),
        backgroundColor: const Color(0xFF1F41BB),
      ),
      body: Container(
        child: Column(children: [
          SizedBox(
            height: Get.height / 60,
          ),
          CarouselSlider(
            items: widget.productModel.productImages
                .map((imageUrls) => ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: imageUrls,
                        fit: BoxFit.fill,
                        width: 150,
                        placeholder: (context, url) => ColoredBox(
                          color: Colors.white,
                          child: Center(child: CupertinoActivityIndicator()),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
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
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.productModel.productName,
                            style: TextStyle(
                                color: Color(0xFFCF1919),
                                fontFamily: 'Poppins',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800),
                          ),
                          Icon(Icons.favorite_border_outlined)
                        ]),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        widget.productModel.isSale == true &&
                                widget.productModel.salePrice != ''
                            ? Text(
                                "₹ ${widget.productModel.salePrice}",
                                style: TextStyle(
                                    color: Color(0xFF519B58),
                                    fontFamily: 'Poppins',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w800),
                              )
                            : Text(
                                "₹${widget.productModel.fullPrice}",
                                style: TextStyle(
                                    color: Color(0xFF519B58),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text("Category : ${widget.productModel.categoryName}",style: TextStyle(
                        color: const Color(0xFF494949),
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500)),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 180),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(widget.productModel.productDescription,style: TextStyle(
                        color: const Color(0xFF494949),
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500)),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        child: Container(
                          width: Get.width / 3.0,
                          height: Get.height / 16,
                          decoration: BoxDecoration(
                              color: const Color(0xFF1F41BB),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: TextButton(
                              onPressed: () {}, child: Row(
                                children: [
                                  SizedBox(width: 10.w,),
                                  SvgPicture.asset('assets/images/logos_whatsapp-icon.svg',width: 30,height: 30,),
                                  SizedBox(width: 10.w,),
                                  Text("WhatsApp",style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500)),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      Material(
                        child: Container(
                          width: Get.width / 3.0,
                          height: Get.height / 16,
                          decoration: BoxDecoration(
                              color: const Color(0xFF1F41BB),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: TextButton(
                              onPressed: () async {
                                await checkProductExistance(uId: user!.uid);
                              },
                              child: Text("Add to cart",style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 14.sp,
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
      ),
    );
  }

  Future<void> checkProductExistance(
      {required String uId, int quantityIncrement = 1}) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrders')
        .doc(widget.productModel.productId.toString());
    DocumentSnapshot snapshot = await documentReference.get();
    if (snapshot.exists) {
      print("Product already exist");
      print("Product quantity updated: $quantityIncrement");
      int currentQuantity = snapshot['productQuantity'];
      int updatedQuantity = currentQuantity + quantityIncrement;
      print("Product quantity updated: $updatedQuantity");
      double totalPrice = double.parse(widget.productModel.isSale
              ? widget.productModel.salePrice
              : widget.productModel.fullPrice) *
          updatedQuantity;
      print("Product quantity updated: $totalPrice");
      await documentReference.update({
        'productQuantity': updatedQuantity,
        'productTotalPrice': totalPrice
      });
    } else {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(uId)
          .set({'uId': uId, 'createdAt': DateTime.now()});
      CartModel cartModel = CartModel(
        productId: widget.productModel.productId,
        categoryId: widget.productModel.categoryId,
        productName: widget.productModel.productName,
        categoryName: widget.productModel.categoryName,
        salePrice: widget.productModel.salePrice,
        fullPrice: widget.productModel.fullPrice,
        productImages: widget.productModel.productImages,
        deliveryTime: widget.productModel.deliveryTime,
        isSale: widget.productModel.isSale,
        productDescription: widget.productModel.productDescription,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        productQuantity: 1,
        productTotalPrice: double.parse(widget.productModel.isSale
            ? widget.productModel.salePrice
            : widget.productModel.fullPrice),
      );
      await documentReference.set(cartModel.toMap());
      print("product added");
    }
  }
}
