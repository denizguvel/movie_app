enum IconEnum {
  arrow('arrow'),
  fav('fav'),
  heart('hearts'),
  premium('premium');

  const IconEnum(this.value);
  final String value;

  String get pngPath => 'assets/icons/$value.png';
}
