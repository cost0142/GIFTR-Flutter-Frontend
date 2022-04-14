class Person {
  String fullName = "";
  String birthDate = "";
  String owner = "";
  List<String> shareWith = [];
  List<Map> gifts = [];
  String image = "";

  Person({
    required this.fullName,
    required this.birthDate,
    required this.owner,
    required this.shareWith,
    required this.gifts,
    required this.image,
  });

  Person.fromJson(Map<String, dynamic> userMap) {
    this.fullName = userMap['fullName'];
    this.birthDate = userMap['birthDate'];
    this.owner = userMap['owner'];
    this.shareWith = userMap['shareWith'];
    this.gifts = userMap['gifts'];
    this.image = userMap['image'];
  }
}
