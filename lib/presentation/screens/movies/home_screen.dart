import 'package:flutter/material.dart';
import 'package:grupoalianza_test_cine/presentation/screens/views/movies/home_view.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: HomeView(),
    );
  }
}
