import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/common/widgets/bottom_navbar/app_bottom_navbar.dart';
import 'package:movie_app/app/common/widgets/bottom_navbar/app_bottom_navbar_bloc.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/app/common/router/app_router.gr.dart';
import 'package:movie_app/app/features/presentation/profile/bloc/profile_bloc.dart';
import 'package:movie_app/app/features/presentation/profile/bloc/profile_event.dart';
import 'package:movie_app/app/features/presentation/profile/bloc/profile_state.dart';
import 'package:movie_app/app/features/presentation/profile/widgets/limited_offer_bottom_sheet.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';
import 'package:movie_app/app/features/presentation/profile/widgets/profile_limited_offer_button.dart';
import 'package:movie_app/app/features/presentation/profile/widgets/profile_view_body.dart';

@RoutePage()
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    bool favoriteMoviesRequested = false;
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfilePhotoUploadSuccess) {
          context.read<ProfileBloc>().add(FetchProfileRequested());
        }
      },
      child: BlocBuilder<AppBottomNavbarBloc, int>(
        bloc: getIt<AppBottomNavbarBloc>(),
        builder: (context, currentIndex) {
          context.read<ProfileBloc>().add(FetchProfileRequested());
          if (!favoriteMoviesRequested) {
            context.read<ProfileBloc>().add(FetchFavoriteMoviesRequested());
            favoriteMoviesRequested = true;
          }
          return Scaffold(
            backgroundColor: AppColors.black,
            appBar: AppBar(
              backgroundColor: AppColors.black,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                  size: 28,
                ),
                onPressed: () => context.router.pop(),
              ),
              title: Text(
                AppStrings.profileDetail,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              actions: [
                ProfileLimitedOfferButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: AppColors.transparent,
                      builder: (_) => const LimitedOfferBottomSheet(),
                    );
                  },
                ),
              ],
            ),
            body: const ProfileViewBody(),
            bottomNavigationBar: AppBottomNavbar(
              selectedIndex: currentIndex,
              onTap: (index, context) {
                getIt<AppBottomNavbarBloc>().add(
                  AppBottomNavbarEvent.values[index],
                );
                if (index == 0) {
                  context.router.replace(const HomeRoute());
                }
              },
            ),
          );
        },
      ),
    );
  }
}
