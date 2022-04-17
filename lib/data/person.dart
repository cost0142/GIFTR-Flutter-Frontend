class Person {
  String fullName = "";
  String birthDate = "";
  String owner = "";
  List<String> shareWith = [];
  List<Map> gifts = [];
  String image = "";

//constructor
  Person({
    required this.fullName,
    required this.birthDate,
    required this.owner,
    required this.shareWith,
    required this.gifts,
    required this.image,
  });

  //the fromJson constructor method that will convert from userMap to our User object.
  Person.fromJson(Map<String, dynamic> userMap) {
    this.fullName = userMap['fullName'];
    this.birthDate = userMap['birthDate'];
    this.owner = userMap['owner'];
    this.shareWith = userMap['shareWith'];
    this.gifts = userMap['gifts'];
    this.image = userMap['image'];
  }
}
