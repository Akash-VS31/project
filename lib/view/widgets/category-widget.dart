import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../model/categories-model.dart';
import '../user_panel/all-categories-screen.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('categories').get(),
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
          return Container(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                CategoriesModel categoriesModel = CategoriesModel(
                  categoryId: snapshot.data!.docs[index]['categoryId'],
                  categoryImg: snapshot.data!.docs[index]['categoryImg'],
                  categoryName: snapshot.data!.docs[index]['categoryName'],
                  createdAt: snapshot.data!.docs[index]['createdAt'],
                  updatedAt: snapshot.data!.docs[index]['updatedAt'],
                );
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () => Get.to(() => AllSingleCategoryProductsScreen(
                          categoryId: categoriesModel.categoryId)),
                      child: SizedBox(
                        height: 100.h,
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xFFC0C0C0),
                              radius: 35.r,
                              child: CachedNetworkImage(
                                imageUrl: categoriesModel.categoryImg,
                                fit: BoxFit.fill,
                                width: 45.w,
                                placeholder: (context, url) => ColoredBox(
                                  color: Colors.white,
                                  child: Center(child: CupertinoActivityIndicator()),
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              categoriesModel.categoryName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF494949),
                                fontSize: 14.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 0.h,
                              ),
                            )
                          ],
                        ),
                      )),
                );
              },
            ),
          );
        }

        return Container();
      },
    );
  }
}
