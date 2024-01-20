class Category {
  String title;
  int donationRaised;
  int donationRequired;

  Category({
    required this.title,
    required this.donationRaised,
    required this.donationRequired,
  });
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      title: json['title'].toString().trim().contains('shelter')
          ? "Shelter 🏠"
          : json['title'].toString().trim().contains('food & water')
              ? "Food & Water 🥗"
              : "First Aid ⛑️",
      donationRaised: json['donation raised'] is String
          ? double.parse(json['donation raised']).toInt()
          : json['donation raised'],
      donationRequired: json['needed to be raised'],
    );
  }
}
