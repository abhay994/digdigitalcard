import 'package:digitalcard/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setPreferredOrientations();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: splashScreen,
      routes: <String, WidgetBuilder>{
         splashScreen: (BuildContext context) => SplashScreen(),
         homeScreen: (BuildContext context) => HomeScreen(),
         createProfile: (BuildContext context) =>Profile(userProfileType: UserProfileType.create) ,
      },

    );
  }
}




