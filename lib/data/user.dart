class User {
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';

//constructor
  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  //the fromJson constructor method that will convert from userMap to our User object.
  User.fromJSON(Map<String, dynamic> userMap) {
    firstName = userMap['firstName'];
    lastName = userMap['lastName'];
    email = userMap['email'];
    password = userMap['password'];
  }
}
