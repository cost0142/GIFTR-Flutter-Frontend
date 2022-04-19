import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/http_helper.dart';

enum Screen { LOGIN, PEOPLE, GIFTS, ADDGIFT, ADDPERSON }

class PeopleScreen extends StatefulWidget {
  PeopleScreen(
      {Key? key,
      required this.logout,
      required this.goGifts,
      required this.goEdit})
      : super(key: key);

  Function(String, String) goGifts;
  Function(String, String, DateTime) goEdit;
  Function(Enum) logout;

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  HttpHelper httpAPI = HttpHelper();

  @override
  void initState() {
    super.initState();
    getPeople();
  }

  //state var list of people
  //real app will be using the API to get the data
  List<dynamic> people = [];

  void getPeople() async {
    List<dynamic> peopleData = await httpAPI.getPeople();
    setState(() => {people = peopleData});
  }

  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    //code here runs for every build
    //someObjects.sort((a, b) => a.someProperty.compareTo(b.someProperty));
    people.sort((a, b) => a.birthDate.month.compareTo(b.birthDate.month));
    //sort the people by the month of birth

    return Scaffold(
      appBar: AppBar(
        title: Text('Giftr - People'),
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
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          return ListTile(
            //different background colors for birthdays that are past
            tileColor: today.month > people[index].birthDate.month
                ? Colors.black12
                : Colors.white,
            title: Text(people[index].fullName),
            subtitle: Text(DateFormat.MMMd().format(people[index].birthDate)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.grey),
                  onPressed: () {
                    print('edit person $index');
                    print('go to the add_person_screen');
                    print(people[index].id);
                    widget.goEdit(people[index].id, people[index].fullName,
                        people[index].birthDate);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.lightbulb, color: Colors.amber),
                  onPressed: () {
                    print('view gift ideas for person $index');
                    print('go to the gifts_screen');
                    widget.goGifts(people[index].id, people[index].fullName);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //go to the add gift page
          DateTime now = DateTime.now();
          widget.goEdit('', '', now);
        },
      ),
    );
  }
}
