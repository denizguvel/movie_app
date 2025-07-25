import 'package:flutter/material.dart';
import 'package:movie_app/app/features/presentation/home/widgets/home_content.dart';
import 'package:movie_app/app/features/presentation/home/widgets/home_profile_content.dart';

class HomeViewBody extends StatelessWidget {
  final int currentIndex;
  const HomeViewBody({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: currentIndex == 0
              ? const HomeContent()
              : const HomeProfileContent(),
        ),
      ],
    );
  }
} 