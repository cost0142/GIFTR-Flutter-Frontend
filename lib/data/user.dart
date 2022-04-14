class User {
  String firstname = '';
  String lastname = '';
  String email = '';
  String password = '';

  User({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });

  User.fromJSON(Map<String, dynamic> userMap) {
    firstname = userMap['firstname'];
    lastname = userMap['lastname'];
    email = userMap['email'];
    password = userMap['password'];
  }
}
