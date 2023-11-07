import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/cart_model.dart';
import '../model/product-model.dart';

class AddFirebaseController extends GetxController {
  Future<void> checkProductExistance(
      {required String uId, required ProductModel productModel,int quantityIncrement = 1}) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrders')
        .doc(productModel.productId.toString());
    DocumentSnapshot snapshot = await documentReference.get();
    if (snapshot.exists) {
      print("Product already exist");
      print("Product quantity updated: $quantityIncrement");
      int currentQuantity = snapshot['productQuantity'];
      int updatedQuantity = currentQuantity + quantityIncrement;
      print("Product quantity updated: $updatedQuantity");
      double totalPrice = double.parse(productModel.isSale
          ? productModel.salePrice
          : productModel.fullPrice) *
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
        productId: productModel.productId,
        categoryId: productModel.categoryId,
        productName: productModel.productName,
        categoryName: productModel.categoryName,
        salePrice: productModel.salePrice,
        fullPrice: productModel.fullPrice,
        productImages: productModel.productImages,
        deliveryTime: productModel.deliveryTime,
        isSale:productModel.isSale,
        productDescription: productModel.productDescription,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        productQuantity: 1,
        productTotalPrice: double.parse(productModel.isSale
            ? productModel.salePrice
            : productModel.fullPrice),
      );
      await documentReference.set(cartModel.toMap());
      print("product added");
    }
  }

}