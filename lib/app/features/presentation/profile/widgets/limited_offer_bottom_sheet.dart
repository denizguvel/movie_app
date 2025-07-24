import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movie_app/app/common/enum/svg_enum.dart';
import 'package:movie_app/app/common/widgets/sizedbox/custom_sizedbox.dart';

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
              height: MediaQuery.of(context).size.height * 0.75,
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
                  mainAxisSize: MainAxisSize.min,
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
                    const SizedBox(height: 13),
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
                                  iconSize: 24,
                                  circleSize: 36,
                                ),
                              ),
                              Expanded(
                                child: _BonusIcon(
                                  icon: IconEnum.heart,
                                  label: 'Daha Fazla Eşleşme',
                                  iconSize: 24,
                                  circleSize: 36,
                                ),
                              ),
                              Expanded(
                                child: _BonusIcon(
                                  icon: IconEnum.arrow,
                                  label: 'Öne Çıkarma',
                                  iconSize: 24,
                                  circleSize: 36,
                                ),
                              ),
                              Expanded(
                                child: _BonusIcon(
                                  icon: IconEnum.fav,
                                  label: 'Daha Fazla Beğeni',
                                  iconSize: 24,
                                  circleSize: 36,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Kilidi açmak için bir jeton paketi seçin',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const CustomSizedbox(28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _JetonCard(
                          percent: '+10%',
                          price: '₺99,99',
                          jeton: '330',
                          oldJeton: '200',
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFE53935), Color(0xFF6F060B)],
                          ),

                          labelColor: Color(0xFFE53935),
                          cardWidth: 90,
                        ),
                        const SizedBox(width: 12),
                        _JetonCard(
                          percent: '+70%',
                          price: '₺799,99',
                          jeton: '3.375',
                          oldJeton: '2.000',
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF4F6CFF), Color(0xFFB03A44)],
                          ),
                          labelColor: Color(0xFF4F6CFF),
                          cardWidth: 90,
                        ),
                        const SizedBox(width: 12),
                        _JetonCard(
                          percent: '+35%',
                          price: '₺399,99',
                          jeton: '1.350',
                          oldJeton: '1.000',
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFE53935), Color(0xFF6F060B)],
                          ),
                          labelColor: Color(0xFFE53935),
                          cardWidth: 90,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
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
  final double iconSize;
  final double circleSize;
  const _BonusIcon({
    required this.icon,
    required this.label,
    this.iconSize = 30,
    this.circleSize = 48,
  });

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
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Color(0xFF6F060B),
                Color(0xFFB03A44).withOpacity(0.35),
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.5),
              ],
              stops: [0.66, 0.78, 0.87, 1.0],
            ),
          ),
          child: Center(
            child: Image.asset(icon.pngPath, width: iconSize, height: iconSize),
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
  final Gradient gradient;
  final Color labelColor;
  final double cardWidth;

  const _JetonCard({
    required this.percent,
    required this.price,
    required this.jeton,
    required this.oldJeton,
    required this.gradient,
    required this.labelColor,
    this.cardWidth = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Kart gövdesi
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: gradient,
            ),
            child: Container(
              // Inner glow efekti için overlay
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.1,
                  colors: [Colors.white.withOpacity(0.13), Colors.transparent],
                  stops: const [0.85, 1.0],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18, // Eskiden 32 idi, küçültüldü
                  horizontal: 8, // Eskiden 12 idi, küçültüldü
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 18), // Eskiden 28 idi, küçültüldü
                    Text(
                      oldJeton,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 15, // Eskiden 18 idi
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      jeton,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26, // Eskiden 36 idi
                      ),
                    ),
                    const Text(
                      'Jeton',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15, // Eskiden 18 idi
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 14), // Eskiden 24 idi
                    Divider(
                      color: Colors.white.withOpacity(0.18),
                      thickness: 1,
                      height: 12, // Eskiden 16 idi
                    ),
                    const SizedBox(height: 8), // Eskiden 12 idi
                    Text(
                      price,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16, // Eskiden 22 idi
                      ),
                    ),
                    const Text(
                      'Başına haftalık',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13, // Eskiden 16 idi
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Üstte dışa taşan etiket
          Positioned(
            top: -16, // Eskiden -22 idi, daha yakın
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14, // Eskiden 18 idi
                  vertical: 4, // Eskiden 6 idi
                ),
                decoration: BoxDecoration(
                  gradient:
                      labelColor == Color(0xFFE53935)
                          ? LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.7), // dış kenar
                              Color(0xFFE53935), // orta
                              Color(0xFF6F060B), // merkez
                            ],
                            stops: [0.0, 0.1, 1.0],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )
                          : LinearGradient(
                            colors: [Color(0xFF4F6CFF), Color(0xFFB03A44)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  percent,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13, // Eskiden 16 idi
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
