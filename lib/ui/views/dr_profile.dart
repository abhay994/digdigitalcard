import 'package:digitalcard/exports.dart';

class Profile extends StatefulWidget {
  final UserProfileType? userProfileType;

  Profile({Key? key, @required this.userProfileType}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserProfileController _userProfileController =
      new UserProfileController();

 bool flag=false;
  late Users adminDetail;
  @override
  void initState(){

    // setState(() {
    //   _userProfileController.setUserInfo();
    // });
    // TODO: implement initState
    super.initState();


       setUserInfo();
       //

  }

  void setUserInfo()async{
    adminDetail = (await servicesInstance.getAdmin())!;
   setState(() {
     _userProfileController.imageBase64 = adminDetail.image!=''? base64Decode(adminDetail.image):null;
     _userProfileController.nameController.text= adminDetail.name;
     _userProfileController.professionController.text = adminDetail.profession;
     _userProfileController.aboutController.text=adminDetail.about;
     _userProfileController.githubController.text=adminDetail.githubUrl;
     _userProfileController.mediumController.text=adminDetail.mediumUrl;
     _userProfileController.linkedInController.text=adminDetail.linkedInUrl;
   });
  }


  @override
  Widget build(BuildContext context) {
    switch (widget.userProfileType) {
      case UserProfileType.create:
        {
          return Scaffold(
            body: Frame(
                meenu: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create Profile",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                dashboard: _userProfileFormCreate(),
                dashboardFlex: 8,
                meenuFlex: 1),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                _userProfileController
                    .createUser()
                    .then((value) =>
                        Navigator.popAndPushNamed(context, homeScreen))
                    .catchError((e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Something went wrong"),
                      duration: Duration(milliseconds: 800)));
                });
              },
              child: Icon(Icons.save),
            ),
          );
        }

      case UserProfileType.view:
        {

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: Text(
                  "User Profile",
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.grey),
                        onPressed: () async {
                          servicesInstance.deleteSqlDatabase().then((value) =>
                              Navigator.popAndPushNamed(context, splashScreen));
                        },
                        child: Text("Logout",
                            style: TextStyle(color: Colors.white))),
                  )
                ],
              ),
              backgroundColor: Colors.white,
              body: _userProfileFormEdit(),


              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: () {
                  _userProfileController.updateUser(user: adminDetail).then((value){

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Profile Updated"),
                        duration: Duration(milliseconds: 800)));

                  }).catchError((e){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Something went wrong"),
                        duration: Duration(milliseconds: 800)));
                  });
                },
                child: Icon(Icons.edit),
              ),
            ),
          );


        }

      default:
        return Container();
    }
  }

  Widget _userProfileFormCreate() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: Stack(
        children: [
          Form(
            key: _userProfileController.formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _userProfileController.imageFile != null
                              ? Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Material(
                                        elevation: 5,
                                        child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.17,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.17,
                                            child: Image.file(
                                              _userProfileController.imageFile!,
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                    Positioned(
                                        top: -1,
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _userProfileController
                                                    .imageFile = null;
                                              });
                                            },
                                            child: Icon(
                                              Icons.cancel,
                                              color: Colors.redAccent,
                                            )))
                                  ],
                                )
                              : InkWell(
                                  onTap: () {
                                    _modalBottomSheetImagePick();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.17,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        child:
                                            Image.asset("assets/profile.gif")),
                                  ))),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Card(
                            elevation: 3,
                            child: TextFormField(
                              style: TextStyle(fontSize: 10),
                              controller: _userProfileController.nameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: name,
                              ),
                              keyboardType: TextInputType.text,
                              validator: _userProfileController.validateName,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Card(
                            elevation: 3,
                            child: TextFormField(
                              style: TextStyle(fontSize: 10),
                              controller:
                                  _userProfileController.professionController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: profession,
                              ),
                              keyboardType: TextInputType.text,
                              validator:
                                  _userProfileController.validateProfession,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Card(
                      elevation: 3,
                      child: TextFormField(
                        maxLines: 5,
                        style: TextStyle(fontSize: 10),
                        controller: _userProfileController.aboutController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: about,
                        ),
                        keyboardType: TextInputType.text,
                        validator: _userProfileController.validateabout,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Card(
                      elevation: 3,
                      child: TextFormField(
                        style: TextStyle(fontSize: 10),
                        controller: _userProfileController.githubController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: githubID,
                          hintText: githubUrlHint
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Card(
                      elevation: 3,
                      child: TextFormField(
                        style: TextStyle(fontSize: 10),
                        controller: _userProfileController.linkedInController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: linkedInID,
                          hintText: linkedInUrlHint
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Card(
                      elevation: 3,
                      child: TextFormField(
                        style: TextStyle(fontSize: 10),
                        controller: _userProfileController.mediumController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: mediumID,
                          hintText: mediumUrlHint
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _userProfileFormEdit() {



    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: Stack(
        children: [
         Form(
        key: _userProfileController.formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  _userProfileController.imageBase64 == null
                      ? Expanded(
                      child: _userProfileController.imageFile !=
                          null
                          ? Stack(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.all(8.0),
                            child: Material(
                              elevation: 5,
                              child: Container(
                                  height: MediaQuery.of(
                                      context)
                                      .size
                                      .height *
                                      0.17,
                                  width: MediaQuery.of(
                                      context)
                                      .size
                                      .height *
                                      0.17,
                                  child: Image.file(
                                    _userProfileController
                                        .imageFile!,
                                    fit: BoxFit.fill,
                                  )),
                            ),
                          ),
                          Positioned(
                              top: -1,
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _userProfileController
                                          .imageFile = null;
                                    });

                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    color:
                                    Colors.redAccent,
                                  )))
                        ],
                      )
                          : InkWell(
                          onTap: () {
                            _modalBottomSheetImagePick();
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.all(8.0),
                            child: Container(
                                height:
                                MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.17,
                                width:
                                MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.4,
                                child: Image.asset(
                                    "assets/profile.gif")),
                          )))
                      : Expanded(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              elevation: 5,
                              child: Container(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.17,
                                  width: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.17,
                                  child: Image.memory(
                                    _userProfileController
                                        .imageBase64!,
                                    fit: BoxFit.fill,
                                  )),
                            ),
                          ),
                          Positioned(
                              top: -1,
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _userProfileController
                                          .imageBase64 = null;
                                    });

                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    color: Colors.redAccent,
                                  )))
                        ],
                      )),








                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(top: 5, bottom: 5),
                      child: Card(
                        elevation: 3,
                        child: TextFormField(
                          style: TextStyle(fontSize: 10),
                          controller:
                          _userProfileController.nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: name,
                          ),
                          keyboardType: TextInputType.text,
                          validator:
                          _userProfileController.validateName,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(top: 5, bottom: 5),
                      child: Card(
                        elevation: 3,
                        child: TextFormField(
                          style: TextStyle(fontSize: 10),
                          controller: _userProfileController
                              .professionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: profession,
                          ),
                          keyboardType: TextInputType.text,
                          validator: _userProfileController
                              .validateProfession,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Card(
                  elevation: 3,
                  child: TextFormField(
                    maxLines: 5,
                    style: TextStyle(fontSize: 10),
                    controller:
                    _userProfileController.aboutController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: about,
                    ),
                    keyboardType: TextInputType.text,
                    validator: _userProfileController.validateabout,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Card(
                  elevation: 3,
                  child: TextFormField(
                    style: TextStyle(fontSize: 10),
                    controller:
                    _userProfileController.githubController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: githubID,
                      hintText: githubUrlHint
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Card(
                  elevation: 3,
                  child: TextFormField(
                    style: TextStyle(fontSize: 10),
                    controller:
                    _userProfileController.linkedInController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: linkedInID,
                      hintText: linkedInUrlHint
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Card(
                  elevation: 3,
                  child: TextFormField(
                    style: TextStyle(fontSize: 10),
                    controller:
                    _userProfileController.mediumController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: mediumID,
                      hintText: mediumUrlHint
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
        ],
      ),
    );
  }

  void _modalBottomSheetImagePick() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (builder) {
          return new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0))),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();

                            getImageCamera().then((img) {
                              setState(() {
                                _userProfileController.imageFile = img;
                              });
                            });
                          },
                          child: Text("Camera"),
                        )),
                        Expanded(
                            child: TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();

                            getImageGallary().then((img) {
                              setState(() {
                                _userProfileController.imageFile = img;
                              });
                            });

                            setState(() {});
                          },
                          child: Text("Gallary"),
                        ))
                      ],
                    ),
                  ),
                  // Container(
                  //   height: 200,
                  //   width: 200,
                  //   child: _buildQrView(context),
                  //
                  // ),

                  // TextField(),
                  // TextField(),
                  // TextField(),
                  // TextField(),
                ],
              ));
        });
  }
}
