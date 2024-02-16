class CompanyInfo {
  final String id;
  final String name;
  final String imageUrl;
  final int years;
  final int employees;
  final double rating;

  CompanyInfo({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.years,
    required this.employees,
    required this.rating,
  });

  factory CompanyInfo.fromJson(Map<String, dynamic> json) {
    return CompanyInfo(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      years: json['years'],
      employees: json['employees'],
      rating: json['rating'],
    );
  }
}