import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
            ),
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [],
              ),
            ),
          ])),
    );
  }
}
