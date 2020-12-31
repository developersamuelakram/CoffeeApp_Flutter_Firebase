
import 'package:drinkcoffee/model/user.dart';
import 'package:drinkcoffee/service/database.dart';
import 'package:drinkcoffee/shared/designfortext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _FormKey = GlobalKey<FormState>();
  List<String> sugars = ['0', '1', '2', '3', '4,'];

  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData> (

      stream: DataBaseService(uid: user.uid).userData,
      builder: (context, snapshot) {


        UserData userData = snapshot.data;

        if (snapshot.hasData) {

          return Form (
            key: _FormKey,
            child: Column(

              children: <Widget>[


                Text('Make your coffee', style: TextStyle(fontSize: 25),),

                SizedBox(height: 10,),

                TextFormField(
                  validator: (val)=> val.isEmpty ? 'Please Enter Name' : null,
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  initialValue: userData.name,
                  onChanged: (val) => setState(() => _currentName = val),


                ),

                SizedBox(height: 10,),

                DropdownButtonFormField(
                  value: _currentSugar ?? userData.sugars,
                  decoration: textInputDecoration,
                  items: sugars.map((sugar) {

                    return DropdownMenuItem(

                      value: sugar,
                      child: Text('$sugar sugars'),


                    );
                  }).toList(),

                  onChanged: (val) {

                    setState(() {
                      _currentSugar = val;
                    });

                  },



                ),

                SizedBox(height: 10,),

                Slider(
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  min: 100.0,
                  max: 900.0,
                  divisions: 8, // how many times a slider slid
                  onChanged: (val) {

                    setState(() {
                      _currentStrength = val.round();
                    });

                  },


                ),

                RaisedButton(
                  child: Text('Update', style: TextStyle(color: Colors.pink),),
                  onPressed: ()  async{


                    await DataBaseService(uid: user.uid).udpateUserData(
                      _currentName ?? userData.name,
                      _currentSugar ?? userData.sugars,
                      _currentStrength ?? userData.strength,

                    );

                    Navigator.pop(context);




                  },
                ),







              ]






              ,

            ),



          );



        }
      },



    );



  }
}
