import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/http_helper.dart';
import '../data/person.dart';

enum Screen { LOGIN, PEOPLE, GIFTS, ADDGIFT, ADDPERSON }

class GiftsScreen extends StatefulWidget {
  GiftsScreen(
      {Key? key,
      required this.goPeople,
      required this.logout,
      required this.addGift,
      required this.currentPerson,
      required this.currentPersonName})
      : super(key: key);

  String currentPerson; //the id of the current person
  String currentPersonName;
  Function(Enum) goPeople;
  Function(Enum) logout;
  Function addGift;

  @override
  State<GiftsScreen> createState() => _GiftsScreenState();
}

class _GiftsScreenState extends State<GiftsScreen> {
  HttpHelper httpAPI = HttpHelper();
  List<dynamic> gifts = [];
  List<dynamic>? peopleData;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    findPersonGifts();
  }

  //state var list of people
  //real app will be using the API to get the data

  // void getPeople() async {
  //   peopleData = await httpAPI.getPeople();

  // }

  void findPersonGifts() async {
    Person? person;
    List<dynamic> people = await httpAPI.getPeople();

    people.forEach((element) {
      if (element.id == widget.currentPerson) {
        person = element;
        setState(() {
          gifts = person!.gifts;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //back to the people page using the function from main.dart
            widget.goPeople(Screen.PEOPLE);
          },
        ),
        title: Text('Ideas - ${widget.currentPersonName}'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              //logout and return to login screen
              widget.logout(Screen.LOGIN);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: gifts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(gifts[index]['name']),

              //NumberFormat.simpleCurrency({String? locale, String? name, int? decimalDigits})
              //gifts[index]['price'].toStringAsFixed(2)
              subtitle: Text(
                  '${gifts[index]['store']["storeProductURL"]} ${NumberFormat.simpleCurrency(locale: 'en_CA', decimalDigits: 2).format(gifts[index]['price'])}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () async {
                      print('delete ${gifts[index]['_id']}');
                      await httpAPI.deleteGift(
                          widget.currentPerson, gifts[index]['_id']);
                      //remove from gifts with setState
                      setState(() {
                        // list.where(func).toList()
                        // is like JS array.filter(func)
                        //real app needs to use API to do this.
                        gifts = gifts
                            .where((gift) => gift['_id'] != gifts[index]['_id'])
                            .toList();
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //go to the add gift page
          widget.addGift();
        },
      ),
    );
  }
}
