import 'package:digitalcard/exports.dart';

class CardListController{


  CardListController(){
    servicesInstance.getSavedUsers();
  }

 Future<void> saveUser(Map<String,dynamic> scanData)async{

   Users saveUser = new Users(uid: scanData['uid'],
       image: 'na',
       profession:scanData['profession'],
       type: 'saved',
       name:scanData['name'],
       about: scanData['about'],
       linkedInUrl:scanData['linkedInUrl'],
       githubUrl: scanData['githubUrl'],
       mediumUrl: scanData['mediumUrl'],
       timeStamp: servicesInstance.timeStamp() );

   await servicesInstance.addUser(saveUser);
   await servicesInstance.getSavedUsers();


 }

}