import 'package:digitalcard/exports.dart';



class UserProfileController{



  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController  professionController = new TextEditingController();
  final TextEditingController  linkedInController = new TextEditingController();
  final TextEditingController  aboutController = new TextEditingController();
  final TextEditingController  githubController = new TextEditingController();
  final TextEditingController  mediumController = new TextEditingController();
  String? imageString;
  File? imageFile;
  var imageBase64;



  String? validateName(String? value) {

    if (value!.length<4)
      return "Name should be greater than 10 charaters";
    else
      return null;
  }


  String? validateProfession(String? value) {

    if (value!.length<4)
      return "Profession should be greater than 4 charaters";
    else
      return null;
  }



  String? validateabout(String? value) {

    if (value!.length<6)
      return "About Me should be greater than 6 charaters";
    else
      return null;
  }


  Future<void> createUser() async{
    String? imageToString;
    Users? user;
    if(formKey.currentState!.validate()) {
      imageToString = imageFile != null ? base64Encode(imageFile!.readAsBytesSync()) : "";

       user = new Users(
          uid: servicesInstance.uuidGeneration(),
          timeStamp: servicesInstance.timeStamp(),
          image: imageToString,
          name: nameController.text,
          profession: professionController.text,
          about: aboutController.text,
          linkedInUrl: linkedInController.text,
          mediumUrl: mediumController.text,
          githubUrl: githubController.text,
          type: 'admin'
      );



     await servicesInstance.createSqldatabase();
    }

    await servicesInstance.addUser(user!);


  }

  Future<void> updateUser({required Users? user}) async{
    String? imageToString;

    if(formKey.currentState!.validate()) {
      imageToString = imageFile != null ? base64Encode(imageFile!.readAsBytesSync()) : user!.image;

      user = new Users(
          uid: user!.uid,
          timeStamp: servicesInstance.timeStamp(),
          image: imageToString,
          name: nameController.text,
          profession: professionController.text,
          about: aboutController.text,
          linkedInUrl: linkedInController.text,
          mediumUrl: mediumController.text,
          githubUrl: githubController.text,
          type: 'admin'
      );




    }

    await servicesInstance.updateUser(user!);


  }





}
