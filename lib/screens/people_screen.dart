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

  String? userData;

  @override
  void initState() {
    super.initState();
    waitFor();
  }

  //state var list of people
  //real app will be using the API to get the data
  List<dynamic> people = [];
  List<dynamic>? peopleData;

  Future<List> getPeople() async {
    peopleData = await httpAPI.getPeople();
    print(peopleData);
    return peopleData!;
  }

  Future<String> getUser() async {
    userData = await httpAPI.getUsers();
    return userData!;
  }

  void compareUser() {
    setState(() => {
          people = peopleData!
              .where((person) =>
                  person.owner == userData ||
                  person.shareWith.contains(userData))
              .toList()
        });
  }

  void waitFor() async {
    await getPeople();
    await getUser();
    compareUser();
  }

  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    //code here runs for every build
    //someObjects.sort((a, b) => a.someProperty.compareTo(b.someProperty));
    people.sort((a, b) => a.birthDate.day.compareTo(b.birthDate.day));
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
          return Dismissible(
            key: ValueKey<String>('${people[index].id}'),
            child: ListTile(
              //different background colors for birthdays that are past
              tileColor: today.month > people[index].birthDate.month
                  ? Color.fromARGB(77, 68, 68, 68)
                  : today.month == people[index].birthDate.month &&
                          today.day > people[index].birthDate.day
                      ? Colors.white30
                      : today.month == people[index].birthDate.month &&
                              today.day == people[index].birthDate.day
                          ? Color.fromARGB(255, 77, 119, 177)
                          : Color.fromARGB(255, 29, 93, 149),
              title: Text(people[index].fullName),
              subtitle: Text(DateFormat.MMMd().format(people[index].birthDate)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit,
                        color: Color.fromARGB(255, 232, 232, 232)),
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
            ),
            background: Container(
              alignment: Alignment.centerLeft,
              color: Colors.red,
              child: Padding(
                child: Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(8.0),
              ),
            ),
            direction: DismissDirection.horizontal,
            onDismissed: (direction) {
              print('delete person $index');
              print('delete person ${people[index].id}');
              httpAPI.deletePerson(people[index].id);
              setState(() {
                people.removeAt(index);
              });
            },
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
