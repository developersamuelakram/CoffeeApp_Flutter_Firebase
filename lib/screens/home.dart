import 'package:drinkcoffee/model/brewmodel.dart';
import 'package:drinkcoffee/screens/settingsform.dart';
import 'package:drinkcoffee/service/auth.dart';
import 'package:drinkcoffee/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brewlist.dart';


class Home extends StatelessWidget {

  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void showSettingPanel() {

      showModalBottomSheet(context: context, builder: (context) {

        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),



        );


      });



    }



    return StreamProvider<List<Brew>>.value(
      value: DataBaseService().brews,
      child: Container(
        decoration: BoxDecoration(

          image: DecorationImage(
              fit: BoxFit.cover,
              image:  AssetImage('assets/coffeebg.jpg'),
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text('Welcome'),
            elevation: 0.0,
            actions: <Widget>[

              FlatButton.icon(icon: Icon(Icons.person),
                label: Text('Log out'),
                onPressed: () async {

                await _auth.signOut();
                print ('Signed Out');



              },),

              FlatButton.icon(icon: Icon(Icons.settings),
                label: Text('Settings'),
                onPressed: ()  {




                  showSettingPanel();

                },),




            ],
          ),
          body: BrewList(),

          ),


      ),
    );
  }
}

