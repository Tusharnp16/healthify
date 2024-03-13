import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:healthify/index.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/Video/anime.json'),
      ),
    );
  }
}