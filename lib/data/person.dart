class Person {
  String id = "";
  String fullName = "";
  DateTime birthDate = DateTime.now();
  String owner = "";
  List<dynamic> shareWith = [];
  List<dynamic> gifts = [];
  String image = "";

//constructor
  Person({
    required this.id,
    required this.fullName,
    required this.birthDate,
    required this.owner,
    required this.shareWith,
    required this.gifts,
    required this.image,
  });

  //the fromJson constructor method that will convert from userMap to our User object.
  Person.fromJSON(Map<String, dynamic> userMap) {
    this.fullName = userMap['name'];
    this.birthDate = DateTime.parse(userMap['birthDate']);
    this.owner = userMap['owner'];
    this.shareWith = userMap['sharedWith'];
    this.gifts = userMap['gifts'];
    this.image = userMap['imageUrl'];
  }
}
