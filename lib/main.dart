import 'package:drinkcoffee/screens/authenticate.dart';
import 'package:drinkcoffee/screens/wrapper.dart';
import 'package:drinkcoffee/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,

      child: MaterialApp(

        home: Wrapper(),
      ),
    );
  }
}

