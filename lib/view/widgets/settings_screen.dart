import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

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
