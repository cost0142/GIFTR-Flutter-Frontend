import 'package:flutter/material.dart';
import '../data/http_helper.dart';

enum Screen { SIGNUP, LOGIN, PEOPLE, GIFTS, ADDGIFT, ADDPERSON }

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key, required this.goLogin, required this.goPeople})
      : super(key: key);
  Function goLogin;
  Function goPeople;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  HttpHelper httpAPI = HttpHelper();

  //create global ref key for the form
  final _formKey = GlobalKey<FormState>();
  //state value for user login
  Map<String, dynamic> user = {
    'firstName': '',
    'lastName': '',
    'email': '',
    'password': ''
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              //back to the people page using the function from main.dart
              widget.goLogin();
            },
          ),
          title: Text('SignUp to Giftr'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              //  ---------------------------------------------------------- Email / PAssword -------------------------------------
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildFirstName(),
                    SizedBox(height: 16),
                    _buildLastName(),
                    SizedBox(height: 16),
                    _buildEmail(),
                    SizedBox(height: 16),
                    _buildPassword(),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ************************************************************************************  Onpressed Function ++++++++"Log In"++++++++++++++++++++
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // primary: Colors.purple,
                              ),
                          child: Text('Sign Up'),
                          // ******************************************************************************  Onpressed Function +++++++"Sign Up"+++++++++++++++++++++
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              //validation has been passed so we can save the form
                              _formKey.currentState!.save();
                              await httpAPI.signUp(
                                  user['firstName'],
                                  user['lastName'],
                                  user['email'],
                                  user['password']);
                              await httpAPI.Login(
                                  user['email'], user['password']);
                              print('Sign Up');
                              //triggers the onSave in each form field
                              //call the API function to post the data
                              //accept the response from the server and
                              //save the token in SharedPreferences
                              //go to the people screen
                              widget.goPeople();
                            } else {
                              //form failed validation so exit
                              return;
                            }
                          },
                          // ******************************************************************************  Onpressed Function +++++++"Sign Up"+++++++++++++++++++++
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ));
  }

  InputDecoration _styleField(String label, String hint) {
    return InputDecoration(
      labelText: label, // label
      labelStyle: TextStyle(color: Colors.white),
      // hintText: hint, //placeholder
      border: OutlineInputBorder(),
    );
  }

  TextFormField _buildFirstName() {
    return TextFormField(
      decoration: _styleField('First name', 'FirstName'),
      controller: firstNameController,
      obscureText: false,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: Colors.white, fontSize: 23),
      validator: (String? value) {
        print('called validator in first name');
        if (value == null || value.isEmpty) {
          return 'Please enter your first name';
          //becomes the new errorText value
        } else if (value.length >= 64) {
          return 'Please enter your first name within 64 characters';
        }
        return null; //means all is good
      },
      onSaved: (String? value) {
        //save the email value in the state variable
        setState(() {
          user['firstName'] = value;
        });
      },
    );
  }

  TextFormField _buildLastName() {
    return TextFormField(
      decoration: _styleField('Last name', 'LastName'),
      controller: lastNameController,
      obscureText: false,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: Colors.white, fontSize: 23),
      validator: (String? value) {
        print('called validator in last name');
        if (value == null || value.isEmpty) {
          return 'Please enter your last name';
          //becomes the new errorText value
        } else if (value.length >= 64) {
          return 'Please enter your last name within 64 characters';
        }
        return null; //means all is good
      },
      onSaved: (String? value) {
        //save the email value in the state variable
        setState(() {
          user['lastName'] = value;
        });
      },
    );
  }

  TextFormField _buildEmail() {
    return TextFormField(
      decoration: _styleField('Email', 'Email'),
      controller: emailController,
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: Colors.white, fontSize: 23),
      validator: (String? value) {
        print('called validator in email');
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
          //becomes the new errorText value
        }
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }
        return null; //means all is good
      },
      onSaved: (String? value) {
        //save the email value in the state variable
        setState(() {
          user['email'] = value;
        });
      },
    );
  }

  TextFormField _buildPassword() {
    return TextFormField(
      decoration: _styleField('Password', ''),
      controller: passwordController,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: Colors.white, fontSize: 23),
      validator: (String? value) {
        if (value == null || value.isEmpty || value.length < 5) {
          return 'Please enter your password';
          //becomes the new errorText value
        }
        return null; //means all is good
      },
      onSaved: (String? value) {
        //save the email value in the state variable
        setState(() {
          user['password'] = value;
        });
      },
    );
  }
}
