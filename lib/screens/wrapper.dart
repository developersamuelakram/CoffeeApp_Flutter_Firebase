import 'package:drinkcoffee/model/user.dart';
import 'package:drinkcoffee/screens/authenticate.dart';
import 'package:drinkcoffee/screens/signin.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if (user == null) {

      return Authenticate();

    } else {

      return Home();
    }


  }
}
