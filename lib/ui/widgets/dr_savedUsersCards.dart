import 'dart:ui';

import 'package:digitalcard/exports.dart';

class SavedUserCard extends StatefulWidget {

  final Users user;
  SavedUserCard({Key? key, required this.user}):super(key:key);

  @override
  _SavedUserCardState createState() => _SavedUserCardState();
}

class _SavedUserCardState extends State<SavedUserCard> {
  @override
  Widget build(BuildContext context) {
    return _cards(user: widget.user);
  }

  Widget _cards({required Users user}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){


        },
        child: Container(
          height:  MediaQuery.of(context).size.height*0.25,
          width:MediaQuery.of(context).size.width*0.29 ,
          child: InkWell(
            onTap: ()=> _showMyDialogUsers(user: user),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(50),

                    child: ClipOval(
                      child: Container(

                          child:
                          Image.asset("assets/profile.gif")),
                    ),
                  ),
                  flex: 2,
                ),
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(user.name),
                )),

                Flexible(child: Text(user.profession,textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,)),






              ],
            ),
          ) ,


        ),
      ),
    );
  }

  Future<void> _showMyDialogUsers({ required Users user}) async {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(10.0)), //this right here
            child: Container(
              height: screenHeight * 0.6,
              width: screenWidth * 0.8,
              //    child: _addItemForm
              child: Stack(



                children: [

                  Container(
                    height: screenHeight*0.26,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.greenAccent, Colors.blue]),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(100.0)),

                    ),

                  ),


                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Container(
                        height:screenHeight*0.5,
                        width:screenWidth*0.8 ,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,

                          children: [
                            Expanded(
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(screenHeight/2),

                                child: ClipOval(
                                  child: Container(

                                      child:
                                      Image.asset("assets/profile.gif")),
                                ),
                              ),
                              flex: 2,
                            ),
                            Flexible(child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(user.name,style: TextStyle(color: Colors.white),),
                            )),

                            Flexible(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(user.profession),
                            )),
                            Flexible(child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(user.about,textAlign: TextAlign.center,)),
                            )),

                            SizedBox(height: 10,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () async=> Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewUrl(url: linkedInUrl+user.linkedInUrl))) ,


                                  child: Container(

                                      child:
                                      Image.asset("assets/linkedin.png",height: 40,width: 40,)),
                                ),
                                InkWell(
                                  onTap: () async=> Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewUrl(url: githubUrl+user.githubUrl))),

                                  child: Container(

                                      child:
                                      Image.asset("assets/github.png",height: 40,width: 40,)),
                                ),
                                InkWell(
                                  onTap: () async=> Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewUrl(url: mediumUrl+user.mediumUrl))),
                                  child: Container(

                                      child:
                                      Image.asset("assets/m.png",height: 40,width: 40,)),
                                ),

                              ],
                            ),






                          ],
                        ) ,


                      ),
                      SizedBox(height: 20,),
                      Flexible(
                        child: InkWell(
                          onTap: (){
                            servicesInstance.delete(user.uid).then((value) => Navigator.pop(context));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.delete_forever,size: 30,color: Colors.redAccent,),
                          ),
                        ),
                      ),
                    ],
                  ),







                ],
              ),


            ),
          );
        });
  }

}
