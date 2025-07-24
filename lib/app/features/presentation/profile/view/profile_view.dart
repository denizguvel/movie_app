import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:movie_app/app/common/widgets/bottom_navbar/app_bottom_navbar.dart';
import 'package:movie_app/app/common/widgets/bottom_navbar/app_bottom_navbar_bloc.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/app/common/router/app_router.gr.dart';
import 'package:movie_app/app/features/presentation/profile/widgets/limited_offer_bottom_sheet.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

@RoutePage()
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Profile açılır açılmaz backend'den user bilgisini çek
    context.read<ProfileBloc>().add(FetchProfileRequested());
    // Mock veriler
    final likedMovies = [
      {
        'image': 'https://i.imgur.com/1.jpg',
        'title': 'Aşk, Ekmek, Hayaller',
        'studio': 'Adam Yapım',
      },
      {
        'image': 'https://i.imgur.com/2.jpg',
        'title': 'Gece Karanlık',
        'studio': 'Fox Studios',
      },
      {
        'image': 'https://i.imgur.com/3.jpg',
        'title': 'Aşk, Ekmek, Hayaller',
        'studio': 'Adam Yapım',
      },
      {
        'image': 'https://i.imgur.com/4.jpg',
        'title': 'Gece Karanlık',
        'studio': 'Fox Studios',
      },
    ];

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfilePhotoUploadSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Fotoğraf başarıyla yüklendi!')),
          );
        } else if (state is ProfilePhotoUploadFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: BlocBuilder<AppBottomNavbarBloc, int>(
        bloc: getIt<AppBottomNavbarBloc>(),
        builder: (context, currentIndex) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () => context.router.pop(),
              ),
              title: const Text(
                'Profil Detayı',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const LimitedOfferBottomSheet(),
                      );
                    },
                    icon: const Icon(
                      Icons.local_offer,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: const Text('Sınırlı Teklif'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profil üst kısmı
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profil fotoğrafı
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          String? photoUrl;
                          bool isUploading = false;
                          if (state is ProfileLoaded) {
                            photoUrl = state.photoUrl;
                          } else if (state is ProfilePhotoUploading) {
                            // Yükleme sırasında eski url'yi koru
                            final previousState = context.read<ProfileBloc>().state;
                            if (previousState is ProfileLoaded) {
                              photoUrl = previousState.photoUrl;
                            }
                            isUploading = true;
                          }
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 38,
                                backgroundColor: Colors.grey[800],
                                backgroundImage: (photoUrl != null && photoUrl.isNotEmpty)
                                    ? NetworkImage(photoUrl)
                                    : null,
                              ),
                              if (isUploading)
                                const Positioned.fill(
                                  child: Center(
                                    child: CircularProgressIndicator(color: Colors.red),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            String displayName = 'Kullanıcı';
                            String displayId = '';
                            
                            if (state is ProfileLoaded) {
                              final user = state.user;
                              final userName = user.name ?? user.firstName ?? user.username ?? 'Kullanıcı';
                              displayName = userName;
                              displayId = state.userId ?? '';
                            }
                            
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  displayName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'ID: $displayId',
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          bool isUploading = state is ProfilePhotoUploading;
                          return ElevatedButton(
                            onPressed:
                                isUploading
                                    ? null
                                    : () async {
                                      final picker = ImagePicker();
                                      final picked = await picker.pickImage(
                                        source: ImageSource.gallery,
                                      );
                                      if (picked != null) {
                                        context.read<ProfileBloc>().add(
                                          UploadProfilePhotoRequested(
                                            File(picked.path),
                                          ),
                                        );
                                      }
                                    },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                            ),
                            child: const Text(
                              'Fotoğraf Ekle',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Beğendiğim Filmler',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // GridView
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: likedMovies.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 18,
                          crossAxisSpacing: 18,
                          childAspectRatio: 0.72,
                        ),
                    itemBuilder: (context, index) {
                      final movie = likedMovies[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          color: Colors.white10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  movie['image']!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie['title']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      movie['studio']!,
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
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
