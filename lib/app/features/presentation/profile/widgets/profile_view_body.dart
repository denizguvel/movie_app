import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:movie_app/app/common/router/app_router.gr.dart';
import 'package:movie_app/app/features/presentation/profile/bloc/profile_bloc.dart';
import 'package:movie_app/app/features/presentation/profile/bloc/profile_state.dart';
import 'package:movie_app/app/features/presentation/profile/bloc/profile_event.dart';
import 'package:movie_app/app/features/data/models/movie/movie_model.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/widgets/sizedbox/custom_sizedbox.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';
import 'package:movie_app/app/features/presentation/profile/widgets/profile_header.dart';
import 'package:movie_app/app/features/presentation/profile/widgets/profile_favorite_movies.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  List<MovieModel>? lastFavoriteMovies;
  bool favoriteMoviesRequested = false;

  @override
  Widget build(BuildContext context) {
    if (!favoriteMoviesRequested) {
      context.read<ProfileBloc>().add(FetchFavoriteMoviesRequested());
      favoriteMoviesRequested = true;
    }
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      children: [
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            String? photoUrl;
            String displayName = AppStrings.user;
            String displayId = '';
            bool isUploading = false;
            if (state is ProfileLoaded) {
              final user = state.user;
              displayName = user.name ?? user.firstName ?? user.username ?? AppStrings.user;
              displayId = state.userId ?? '';
              photoUrl = state.photoUrl;
            } else if (state is ProfilePhotoUploading) {
              final previousState = context.read<ProfileBloc>().state;
              if (previousState is ProfileLoaded) {
                photoUrl = previousState.photoUrl;
                displayName = previousState.userName ?? AppStrings.user;
                displayId = previousState.userId ?? '';
              }
              isUploading = true;
            }
            return ProfileHeader(
              photoUrl: photoUrl,
              displayName: displayName,
              displayId: displayId,
              isUploading: isUploading,
              onAddPhoto: () {
                context.router.push(const UploadPhotoRoute());
              },
            );
          },
        ),
        const CustomSizedbox(28),
        Text(
          AppStrings.myFavoriteMovies,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const CustomSizedbox(16),
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileFavoriteMoviesLoaded) {
              lastFavoriteMovies = state.favoriteMovies;
            }
            final moviesToShow = lastFavoriteMovies ?? [];
            final isLoading = state is ProfileInitial;
            return ProfileFavoriteMovies(
              movies: moviesToShow,
              isLoading: isLoading,
            );
          },
        ),
        const CustomSizedbox(24),
      ],
    );
  }
} 