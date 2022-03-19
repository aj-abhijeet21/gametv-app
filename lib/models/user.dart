class UserDetails {
  String name;
  String rating;
  String played;
  String won;
  String percentage;
  String imgUrl;

  UserDetails({
    required this.name,
    required this.percentage,
    required this.played,
    required this.rating,
    required this.won,
    required this.imgUrl,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      name: json['username'],
      percentage: json['percentage'],
      played: json['played'],
      rating: json['rating'],
      won: json['won'],
      imgUrl: json['imgurl'],
    );
  }
}
