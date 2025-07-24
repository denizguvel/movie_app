import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
      ),
      body: const Center(
        child: Text(
          'Hoşgeldin!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
