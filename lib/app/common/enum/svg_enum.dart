import 'package:flutter/material.dart';

/// PNG ikonlar için enum
enum IconEnum {
  arrow('arrow'),
  fav('fav'),
  heart('heart'),
  premium('premium');

  const IconEnum(this.value);
  final String value;

  String get pngPath => 'assets/icons/$value.png';
}
