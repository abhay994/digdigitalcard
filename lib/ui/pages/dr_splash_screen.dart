import 'package:digitalcard/exports.dart';

// class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: [
//            Expanded(child: Image.asset('assets/cardsplash.gif')),
//            Flexible(child: FittedBox(child: Text('DigitalVCard',style: Theme.of(context).textTheme.headline4,)))
//          ],
//        ),
//
//       ),
//     );
//   }
// }

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {



    // TODO: implement initState
    super.initState();
    navigate();
  }

  void navigate() async{
    servicesInstance.initializeSqlDatabase().then((flag){
  Future.delayed(Duration(seconds: 10),(){
    if(flag){
      Navigator.popAndPushNamed(context, homeScreen);
    }else{
      Navigator.popAndPushNamed(context, createProfile);
    }
  });



    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Expanded(child: Image.asset('assets/cardsplash.gif')),
           Flexible(child: FittedBox(child: Text('DigitalVCard',style: Theme.of(context).textTheme.headline4,)))
         ],
       ),

      ),
    );
  }
}


