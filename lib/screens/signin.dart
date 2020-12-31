import 'package:drinkcoffee/service/auth.dart';
import 'package:drinkcoffee/shared/designfortext.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  Function toggleView;
  SignIn({this.toggleView});


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  AuthService _auth = AuthService();

  final _formkey = GlobalKey<FormState>();
  String email = "";
  String password = " ";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In - Coffee App'),
        elevation: 0.0,
        actions: <Widget>[

          FlatButton.icon(icon: Icon(Icons.person)
            ,
         label: Text('Sign Up'),
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
                  validator: (val) => password.length <6 ? 'Please enter 6 Chars' : null,
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
                  child: Text('Sign In'),
                  color: Colors.pink,
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {


                      dynamic result = await _auth.signInUserWithEmailandPassword(email, password);

                      if (result != null) {


                        print('successfully signed in');
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
