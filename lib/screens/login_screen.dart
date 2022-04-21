import 'package:flutter/material.dart';
import '../data/http_helper.dart';

enum Screen { LOGIN, PEOPLE, GIFTS, ADDGIFT, ADDPERSON }

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key, required this.nav}) : super(key: key);
  Function nav;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  HttpHelper httpAPI = HttpHelper();

  //create global ref key for the form
  final _formKey = GlobalKey<FormState>();
  //state value for user login
  Map<String, dynamic> user = {'email': '', 'password': ''};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login to Giftr'),
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
                    _buildEmail(),
                    SizedBox(height: 16),
                    _buildPassword(),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ******************************************************************************  Onpressed Function +++++++++"Log In"++++++++++++++++
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              //validation has been passed so we can save the form
                              _formKey.currentState!.save();
                              String string = await httpAPI.Login(
                                  user['email'], user['password']);
                              if (string != null) widget.nav();
                              //triggers the onSave in each form field
                              //call the API function to post the data
                              //accept the response from the server and
                              //save the token in SharedPreferences
                              //go to the people screen
                            } else {
                              //form failed validation so exit
                              return;
                            }
                          },
                          icon: Icon(Icons.arrow_forward),
                          label: Text('Log In'),
                        ),
                        // ************************************************************************************  Onpressed Function ++++++++"Log In"++++++++++++++++++++
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // primary: Colors.purple,
                              ),
                          child: Text('Sign Up'),
                          // ******************************************************************************  Onpressed Function +++++++"Sign Up"+++++++++++++++++++++
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              //validation has been passed so we can save the form
                              _formKey.currentState!.save();
                              httpAPI.signUp(
                                  '', '', user['email'], user['password']);
                              print('Sign Up');
                              //triggers the onSave in each form field
                              //call the API function to post the data
                              //accept the response from the server and
                              //save the token in SharedPreferences
                              //go to the people screen
                              widget.nav();
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
          return 'Please enter something';
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
          return 'Please enter something';
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
