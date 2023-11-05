import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../../model/product-model.dart';

class AllSingleCategoryProductsScreen extends StatefulWidget {
  String categoryId;
  AllSingleCategoryProductsScreen({super.key, required this.categoryId});

  @override
  State<AllSingleCategoryProductsScreen> createState() =>
      _AllSingleCategoryProductsScreenState();
}

class _AllSingleCategoryProductsScreenState
    extends State<AllSingleCategoryProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F41BB),
        title: Text('Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('products')
              .where('categoryId', isEqualTo: widget.categoryId)
              .get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: Get.height / 5,
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text("No category found!"),
              );
            }

            if (snapshot.data != null) {
              return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .90,
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
                          width: 2.0,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(.5),
                              offset: Offset(3, 2),
                              blurRadius: 7)
                        ]),
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Image.network(
                              productModel.productImages[0],
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Text(productModel.productName,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(' ₹ ${productModel.fullPrice}',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            IconButton(
                                icon: Icon(Icons.add_shopping_cart),
                                onPressed: () {

                                })
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
        ),
      ),
    );
  }
}
