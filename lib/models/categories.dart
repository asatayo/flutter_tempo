class ServiceCategory {
  final String name;
  final String value;
  final String iconPath;
  final bool isHouse;
  final bool isRental;
  bool isChecked = false;
  ServiceCategory({required this.name, required this.iconPath, required this.value, required this.isHouse, required this.isRental, required this.isChecked});
  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
        isChecked: false,
        name: json['name'],
        value: json['value'],
        isHouse: json['isHouse'],
        isRental: json['isRental'],
        iconPath: json['iconPath']);
  }
}
