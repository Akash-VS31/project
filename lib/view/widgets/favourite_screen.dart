import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1F41BB),
          title: Text("Favourite"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
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
      ),
    );
  }
}
