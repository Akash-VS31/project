import 'package:deal_ninja_spectrum/view/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
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
    );
  }
}
