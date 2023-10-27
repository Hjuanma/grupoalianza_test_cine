import 'package:flutter/material.dart';
import 'package:grupoalianza_test_cine/config/constants/environment.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Environmet.theMovieDbKey),
      ),
    );
  }
}
