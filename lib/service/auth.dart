import 'package:drinkcoffee/model/user.dart';
import 'package:drinkcoffee/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {


  FirebaseAuth _auth = FirebaseAuth.instance;


  User userfromfirebase (FirebaseUser user) {

    // if user is true then return user id if there is no user then user id is null
    return user!=null ? User(uid: user.uid) : null;
  }

  // register method

  Future resgisterUserWithEmailandPassword(String email, String password) async {

    try {

      AuthResult registerresult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser signinuser = registerresult.user;


      await DataBaseService(uid: signinuser.uid).udpateUserData("New User", "0", 100);

      return userfromfirebase(signinuser);


    } catch (e) {

      print (e.toString());
    }

  }






  // signin method


  Future signInUserWithEmailandPassword(String email, String password) async {

    try {

      AuthResult signUpResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser signupuser = signUpResult.user;
      return userfromfirebase(signupuser);


    } catch (e) {

      print (e.toString());
    }

  }




  // signout


  Future signOut() async {

    await _auth.signOut();

  }


  // stream  (authentication changes - singin or sign out


 Stream<User> get user {


    return _auth.onAuthStateChanged.map(userfromfirebase);


 }




}