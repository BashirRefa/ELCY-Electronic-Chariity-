class ProfileMode {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;

  ProfileMode({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.address,
  });

  factory ProfileMode.fromJson(Map<String, dynamic> json) {
    return ProfileMode(
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }
}
