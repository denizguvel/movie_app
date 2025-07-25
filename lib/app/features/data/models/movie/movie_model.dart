class MovieModel {
  final String id;
  final String title;
  final String description;
  final String posterUrl;

  const MovieModel({
    required this.id,
    required this.title,
    required this.description,
    required this.posterUrl,
  });

  MovieModel copyWith({
    String? id,
    String? title,
    String? description,
    String? posterUrl,
  }) {
    return MovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      posterUrl: posterUrl ?? this.posterUrl,
    );
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] as String? ?? map['_id'] as String? ?? '',
      title: map['title'] as String? ?? map['Title'] as String? ?? '',
      description: map['description'] as String? ?? map['Plot'] as String? ?? '',
      posterUrl: map['posterUrl'] as String? ?? map['Poster'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'posterUrl': posterUrl,
    };
  }
}
