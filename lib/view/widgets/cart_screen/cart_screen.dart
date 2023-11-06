import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../model/cart_model.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(user!.uid) // Use the current user's UID
            .collection('cartOrders')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
              return ListTile(
                title: Text(cartProduct.productName),
                subtitle: Text('Quantity: ${cartProduct.productQuantity}'),
                trailing: Text(
                    '₹${cartProduct.productTotalPrice.toStringAsFixed(2)}'),
                // Implement a button or action to remove the item from the cart.
              );
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Total: ₹${calculateTotalPrice().toStringAsFixed(2)}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement the checkout logic here.
              },
              child: Text('Proceed to Checkout'),
            ),
          ],
        ),
      ),
    );
  }

  double calculateTotalPrice() {
    // Calculate the total price of all items in the cart.
    // You can iterate through the cart items and sum up the productTotalPrice values.
    return 0.0; // Replace with the actual calculation.
  }
}
