class Gift {
  String id = "";
  String name = "";
  double price = 0.0;
  Map<String, String> store = {
    'name': '',
    'storeProductURL': '',
  };
  String? url = '';

//constructor
  Gift({
    required this.id,
    required this.name,
    required this.price,
    required this.store,
    required this.url,
  });

  //the fromJson constructor method that will convert from userMap to our User object.
  Gift.fromJSON(Map<String, dynamic> userMap) {
    id = userMap['id'];
    name = userMap['name'];
    price = userMap['price'];
    store = userMap["store"];
    store['name'] = userMap['store']['name'];
    store["storeProductURL"] = userMap['store']['storeProductURL'];
  }
}
