import 'package:drinkcoffee/service/auth.dart';
import 'package:drinkcoffee/shared/designfortext.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {


  Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  AuthService _auth  = AuthService();


  final _formkey = GlobalKey<FormState>();
  String email = "";
  String password = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up - Coffee App'),
        elevation: 0.0,
        actions: <Widget>[

          FlatButton.icon(icon: Icon(Icons.person)
            ,
            label: Text('Sign In'),
            onPressed: () {
              widget.toggleView(); // handling clickevent
            },

          )

        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Container(
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[

                TextFormField(
                  validator: (val) => email.isEmpty ? 'Please Enter an Email' : null,
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  onChanged: (val) {

                    setState(() {

                      email = val;

                    });


                  },

                ),

                SizedBox(height: 10),

                TextFormField(
                  validator: (val) => password.length < 6 ? 'Please enter 6 Chars' : null,
                  obscureText: true, // hide our password as we type it.
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  onChanged: (val) {

                    setState(() {

                      password = val;

                    });


                  },

                ),

                SizedBox(height: 10),

                RaisedButton(
                    child: Text('Sign Up'),
                    color: Colors.pink,
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {


                        dynamic result = await _auth.resgisterUserWithEmailandPassword(email, password);

                        if (result != null) {


                          print('successfully signed up');
                        }


                      }
                    }),






              ],
            ),
          ),



        ),

      ),
    );
  }
}