import 'package:digitalcard/exports.dart';
import 'package:flutter/cupertino.dart';


class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {

  bool barCodeFlag=true;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  CardListController _cardListController = new CardListController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15,left: 8,right: 8),
      child: Scaffold(
        backgroundColor: Colors.white,
        body:barCodeFlag? Container(
          child: StreamBuilder<List<Map<String,dynamic>>>(
            stream: servicesInstance.savedUserProfileJson,
            builder: (context,   snapshot) {
              if(snapshot.data!=null)
              return GridView.builder(itemCount: snapshot.data!.length,

                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,

                  ),
                  itemBuilder: (context,index){
                    return SavedUserCard(user: Users.fromData(snapshot.data![index]));

                  });

              else
                 return Container();
            }
          )
        ):_buildQrView(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {
              barCodeFlag=!barCodeFlag;

            });

          },
          child: Icon(barCodeFlag?Icons.add:Icons.cancel_outlined),
        ),

      ),
    );

  }





  Widget _buildQrView() {

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.greenAccent,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.height*0.29),
    );
  }


  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;

    var data;
    controller.scannedDataStream.listen((scanData) async {
    data = json.decode(scanData.code);

    await _cardListController.saveUser(data).then((value) => setState(() {


      barCodeFlag=true;

     })).catchError((e){

     setState(() {
       barCodeFlag=true;
     });

     Future.delayed(Duration(milliseconds: 500),(){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
           content: Text("User is already present"),
           duration: Duration(milliseconds: 800)));
     });





   });








    });




  }







  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   controller!.dispose();
  }

}
