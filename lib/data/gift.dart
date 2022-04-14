class Gift {
  String id = "";
  String name = "";
  double price = 0.0;
  String? store = '';
  String? url = '';

  Gift({
    required this.id,
    required this.name,
    required this.price,
    required this.store,
    required this.url,
  });

  Gift.dromJSON(Map<String, dynamic> userMap) {
    id = userMap['id'];
    name = userMap['name'];
    price = userMap['price'];
    store = userMap['store'];
    url = userMap['url'];
  }
}
