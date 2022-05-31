class Regions {
  String name;

  Regions({ required this.name});
  factory Regions.fromJson(Map<String, dynamic> json){
    return  Regions(
      name: json['name'].toString(),
    );
  }

}
