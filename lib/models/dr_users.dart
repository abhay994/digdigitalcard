
class Users{

   late final String uid;
   late final String name;
   late final String image;
   late final String profession;
   late final String about;
   late final String type;
   late final String linkedInUrl;
   late final String githubUrl;
   late final String mediumUrl;
   late final String timeStamp;

   Users({ required this.uid,required this.image,required this.profession,required this.type,required this.name,required this.about, required this.linkedInUrl,
     required this.githubUrl,required this.mediumUrl,required this.timeStamp});

   factory Users.fromData(Map<String, dynamic> data) {
     return Users(
         uid: data['uid'],
         name: data['name'],
         about : data['about'],
         image : data['image'],
         type: data['type'],
         profession : data['profession'],
         linkedInUrl: data['linkedInUrl'],
         githubUrl: data['githubUrl'],
         mediumUrl: data['mediumUrl'],
         timeStamp: data['timeStamp']

     );
   }

   Map<String, dynamic> toJson() {

     return {
       'uid': uid,
       'name': name,
       'image':image,
       'profession':profession,
       'type': type,
       'about': about,
       'linkedInUrl': linkedInUrl,
       'githubUrl':githubUrl,
       'mediumUrl' : mediumUrl,
       'timeStamp':timeStamp,


     };
   }

   Map<String, dynamic> qRcodetoJson() {

     return {
       'uid': uid,
       'name': name,
       'profession':profession,
       'about': about,
       'linkedInUrl': linkedInUrl,
       'githubUrl':githubUrl,
       'mediumUrl' : mediumUrl,
     };
   }


}