import 'package:digitalcard/exports.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget? _bottomWidget ;

  @override
  void initState() {
    setState(() {
      bottomAppBarSwitch(HomeButtomTabs.open);
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Frame(
          meenu: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("DigitalVCard",style: TextStyle(color: Colors.white,fontSize: 20),)
          ],
        ),


      ), dashboard: _bottomWidget,


          dashboardFlex: 8, meenuFlex: 1),

      bottomNavigationBar: BottomAppBar(

    child: Row(
    // mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceAround,

      children: <Widget>[

        InkWell(
          onTap: () async{

            setState(() {
              bottomAppBarSwitch(HomeButtomTabs.barcode);
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.qr_code_scanner_rounded,size: 25),
          ),
        ),

        InkWell(
            onTap: (){
              setState(() {
                bottomAppBarSwitch(HomeButtomTabs.cadeList);
              });

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Icon(Icons.list_alt,size: 25),
            )),

        InkWell(
            onTap: (){
              setState(() {
                bottomAppBarSwitch(HomeButtomTabs.profile);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Icon(Icons.person_pin,size: 25,),
            )),




      ],
    ),

    ),

    );
  }
  void bottomAppBarSwitch(HomeButtomTabs homeButtomTabs){

    switch(homeButtomTabs){
      case HomeButtomTabs.profile:{
        _bottomWidget = Profile(userProfileType: UserProfileType.view,);
      }
      break;
      case HomeButtomTabs.barcode:{
        _bottomWidget =  AdminQRCode();
       // _modalBottomSheetBarCode();

      }
      break;
      case HomeButtomTabs.cadeList:{

        _bottomWidget = CardList();
       // _modalBottomSheetBarCode();


      }
      break;
      case HomeButtomTabs.open:{

        _bottomWidget =  Container(
          child: Image.asset('assets/userlist.gif'),

        );


      }
      break;

      default:{

        _bottomWidget =  Container(
          child: Image.asset('assets/userlist.gif'),

        );
      }

    }


  }

  @override
  void dispose() {
    servicesInstance.dispose();
    // TODO: implement dispose
    super.dispose();
  }



}


