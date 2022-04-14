class Person {
  String id = '';
  String name = '';
  DateTime birthDate = DateTime.now();
  List<Map> gifts = [];
  String owner = '';

  Person({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.owner,
    required this.gifts,
  });

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    birthDate = DateTime.parse(json['birthDate']);
    gifts = json['gifts'];
    owner = json['owner'];
  }
}
