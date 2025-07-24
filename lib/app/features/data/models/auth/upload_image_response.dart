class UploadImageResponse {
  final String photoUrl;

  UploadImageResponse({required this.photoUrl});

  factory UploadImageResponse.fromMap(Map<String, dynamic> map) {
    final data = map['data'] ?? {};
    return UploadImageResponse(photoUrl: data['photoUrl'] ?? '');
  }
}
