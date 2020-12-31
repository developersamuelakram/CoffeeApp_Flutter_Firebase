import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinkcoffee/model/brewmodel.dart';
import 'package:drinkcoffee/model/user.dart';
import 'package:provider/provider.dart';


class DataBaseService {

  String uid;
  DataBaseService({this.uid});

  final CollectionReference brewsCollection = Firestore.instance.collection('brews');

  Future udpateUserData (String name, String sugars, int strength) async {



    return brewsCollection.document(uid).setData({

      'sugars': sugars,
      'name': name,
      'strength': strength,


    });
  }



  //
 List<Brew> brewListfromSnapshot  (QuerySnapshot snapshot) {

    return snapshot.documents.map((doc) {

      // cycle through the whole document
      return Brew(
        name: doc.data['name'],
        strength: doc.data['strength'],
        sugars: doc.data['sugars'],


      );


    }).toList();

 }



 UserData userDataFromSnapshot(DocumentSnapshot documentSnapshot) {


  return UserData(
    uid: uid,
    name: documentSnapshot.data['name'],
    strength: documentSnapshot.data['strength'],
    sugars: documentSnapshot.data['sugars'],

  );

 }

  // get user stream

  Stream<UserData> get userData {

    return brewsCollection.document(uid).snapshots().map(userDataFromSnapshot);


  }

  // listen to the updates/changes in the list

  Stream<List<Brew>> get brews {

  return brewsCollection.snapshots().map(brewListfromSnapshot);

  }
}