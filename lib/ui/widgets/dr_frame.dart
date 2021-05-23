import 'package:digitalcard/exports.dart';

class Frame extends StatefulWidget {
  final Widget? meenu;
  final Widget? dashboard;
  final int? meenuFlex;
  final int? dashboardFlex;

  Frame({Key? key,@required this.meenu,@required this.dashboard,@required this.dashboardFlex,@required this.meenuFlex}):super(key: key);
  @override
  _FrameState createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [Colors.greenAccent, Colors.blue])
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Expanded(child: Container(
              child: widget.meenu,
            ),flex: widget.meenuFlex!,),
            Expanded(child: Container(

              decoration: BoxDecoration(color:Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)


                  )

              ),
              child: widget.dashboard,
            ),flex: widget.dashboardFlex!,
            ),


          ],),
      ),
    );
  }
}
