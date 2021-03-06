import 'package:flutter/material.dart';
import 'package:flutter_multi_screen/screens/add_person_screen.dart';
import '../data/http_helper.dart';

enum Screen { SIGNUP, LOGIN, PEOPLE, GIFTS, ADDGIFT, ADDPERSON }

class AddGiftScreen extends StatefulWidget {
  AddGiftScreen(
      {Key? key,
      required this.nav,
      required this.currentPerson,
      required this.currentPersonName})
      : super(key: key);

  Function nav;
  String currentPersonName; // could be empty string
  String currentPerson; //could be zero

  @override
  State<AddGiftScreen> createState() => _AddGiftScreenState();
}

class _AddGiftScreenState extends State<AddGiftScreen> {
  final nameController = TextEditingController();
  final storeController = TextEditingController();
  final priceController = TextEditingController();
  //create global ref key for the form
  final _formKey = GlobalKey<FormState>();
  //state value for user login
  Map<String, dynamic> gift = {
    'name': '',
    'store': {
      'storeName': '',
      'storeUrl': '',
    },
    'price': 0.00
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //back to the people page using the function from main.dart
            widget.nav(Screen.GIFTS);
          },
        ),
        title: Text('Add Gift - ${widget.currentPersonName}'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildName(),
                SizedBox(height: 16),
                _buildStore(),
                SizedBox(height: 16),
                _buildPrice(),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Save'),
                  onPressed: () async {
                    //use the API to save the new gift for the person
                    //after confirming the save then
                    //go to the gifts screen
                    _formKey.currentState!.save();
                    await httpAPI.addGift(
                      widget.currentPerson,
                      gift['name'],
                      '',
                      gift['price'],
                      gift['store']['storeName'],
                      gift['store']['storeUrl'],
                    );
                    widget.nav(Screen.GIFTS);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _styleField(String label, String hint) {
    return InputDecoration(
      labelText: label, // label
      labelStyle: TextStyle(color: Colors.white),
      hintText: hint, //placeholder
      hintStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(),
    );
  }

  TextFormField _buildName() {
    return TextFormField(
      decoration: _styleField('Idea Name', 'gift idea'),
      controller: nameController,
      obscureText: false,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: Colors.white, fontSize: 23),
      validator: (String? value) {
        print('called validator in email');
        if (value == null || value.isEmpty) {
          return 'Please enter something';
          //becomes the new errorText value
        }
        return null; //means all is good
      },
      onSaved: (String? value) {
        //save the email value in the state variable
        setState(() {
          gift['name'] = value;
        });
      },
    );
  }

  TextFormField _buildStore() {
    return TextFormField(
      decoration: _styleField('Store URL', 'Store URL'),
      controller: storeController,
      obscureText: false,
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: Colors.white, fontSize: 23),
      validator: (String? value) {
        print('called validator in store url');
        if (value == null || value.isEmpty) {
          return 'Please enter something';
          //becomes the new errorText value
        }
        return null; //means all is good
      },
      onSaved: (String? value) {
        //save the email value in the state variable
        setState(() {
          gift['store']['storeUrl'] = value;
        });
      },
    );
  }

  TextFormField _buildPrice() {
    return TextFormField(
      decoration: _styleField('Price', 'Approximate gift price'),
      controller: priceController,
      obscureText: false,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: Colors.white, fontSize: 23),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a price';
          //becomes the new errorText value
        }
        return null; //means all is good
      },
      onSaved: (String? value) {
        //save the email value in the state variable
        setState(() {
          if (value != null) {
            gift['price'] = double.parse(value);
          }
        });
      },
    );
  }
}
