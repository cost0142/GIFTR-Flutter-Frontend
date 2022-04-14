class User {
  String id = '';
  String firstname = '';
  String lastname = '';
  String email = '';

  User(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.email});

  User.fromJSON(Map<String, dynamic> userMap) {
    id = userMap['id'];
    firstname = userMap['firstname'];
    lastname = userMap['lastname'];
    email = userMap['email'];
  }
}
