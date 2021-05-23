import 'package:digitalcard/exports.dart';
import 'package:barcode_widget/barcode_widget.dart' as brw;

class AdminQRCode extends StatefulWidget {
  @override
  _AdminQRCodeState createState() => _AdminQRCodeState();
}


class _AdminQRCodeState extends State<AdminQRCode> {

  Users? adminDetail;
  @override
  void initState() {
    getadminInfo();
    // TODO: implement initState
    super.initState();
  }

  void getadminInfo()async {
    adminDetail = (await servicesInstance.getAdmin())!;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Scaffold(
        backgroundColor: Colors.white,
          appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
          "My QRCode",
          style: TextStyle(color: Colors.black),
      ),
          ),
        body: Container(


          child:adminDetail!=null? Material(
            elevation: 5,
            child: Center(

              child: brw.BarcodeWidget(
                barcode:brw.Barcode.qrCode(), // Barcode type and settings
                data: jsonEncode(adminDetail!.qRcodetoJson()), // Content
                width: 200,
                height: 200,
              ),
            ),
          ):Container(),

        ),
      ),
    );
  }
}
