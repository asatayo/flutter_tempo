class RentalLandlord{
  final String firstName;
  final String surName;
  final String middleName;
  RentalLandlord({required this.firstName, required this.surName, required this.middleName});
  factory RentalLandlord.fromJson(Map<String, dynamic> json) {
    return RentalLandlord(
      firstName: json['first_name'],
      middleName: json['middle_name'],
      surName: json['surname']
    );
  }
}
