class Tournament {
  String name;
  String? imgUrl;
  String details;

  Tournament({
    required this.details,
    this.imgUrl,
    required this.name,
  });

  factory Tournament.fromJson(Map json) {
    return Tournament(
      details: json['details'],
      imgUrl: json['cover_url'],
      name: json['name'],
    );
  }
}
