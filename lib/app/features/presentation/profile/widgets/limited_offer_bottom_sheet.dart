import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/app/common/enum/svg_enum.dart';

class LimitedOfferBottomSheet extends StatelessWidget {
  const LimitedOfferBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF7B0B1D), Color(0xFF1A0A0A)],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Sınırlı Teklif',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Jeton paketini seçerek bonus kazanın ve yeni bölümlerin kilidini açın!',
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 8,
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Alacağınız Bonuslar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: _BonusIcon(
                                  icon: IconEnum.premium,
                                  label: 'Premium Hesap',
                                ),
                              ),
                              Expanded(
                                child: _BonusIcon(
                                  icon: IconEnum.heart,
                                  label: 'Daha Fazla Eşleşme',
                                ),
                              ),
                              Expanded(
                                child: _BonusIcon(
                                  icon: IconEnum.arrow,
                                  label: 'Öne Çıkarma',
                                ),
                              ),
                              Expanded(
                                child: _BonusIcon(
                                  icon: IconEnum.fav,
                                  label: 'Daha Fazla Beğeni',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Kilidi açmak için bir jeton paketi seçin',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        _JetonCard(
                          percent: '+10%',
                          price: '₺99,99',
                          jeton: '330',
                          oldJeton: '200',
                          color: Colors.red,
                        ),
                        _JetonCard(
                          percent: '+70%',
                          price: '₺799,99',
                          jeton: '3.375',
                          oldJeton: '2.000',
                          color: Colors.blueAccent,
                        ),
                        _JetonCard(
                          percent: '+35%',
                          price: '₺399,99',
                          jeton: '1.350',
                          oldJeton: '1.000',
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        child: const Text(
                          'Tüm Jetonları Gör',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BonusIcon extends StatelessWidget {
  final IconEnum icon;
  final String label;
  const _BonusIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final displayLabel =
        label == 'Öne Çıkarma'
            ? 'Öne\nÇıkarma'
            : label == 'Daha Fazla Eşleşme'
            ? 'Daha\nFazla Eşleşme'
            : label == 'Daha Fazla Beğeni'
            ? 'Daha\nFazla Beğeni'
            : label;
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: Colors.white12,
          child: Image.asset(
            icon.pngPath,
            width: 50,
            height: 50,
            color: Colors.pinkAccent,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          displayLabel,
          style: const TextStyle(color: Colors.white, fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _JetonCard extends StatelessWidget {
  final String percent;
  final String price;
  final String jeton;
  final String oldJeton;
  final Color color;

  const _JetonCard({
    required this.percent,
    required this.price,
    required this.jeton,
    required this.oldJeton,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.85), Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                percent,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              oldJeton,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 16,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            Text(
              jeton,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const Text(
              'Jeton',
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),
            const SizedBox(height: 10),
            Text(
              price,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Text(
              'Başına haftalık',
              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
