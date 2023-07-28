import 'package:blog/QR/scan_qr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';


class QRScreen extends StatefulWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {

  final qrKey = GlobalKey();
  String qrData = 'Hello! Buddy';
  String? _scanCode ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          _scanCode==null?SizedBox():Text("Scanned Code -  $_scanCode",style: TextStyle(color: Colors.blue,fontSize: 18,),),
        SizedBox(height: 20,),
        Center(
          child: RepaintBoundary(
          key: qrKey,
          child: QrImage(
            data: qrData, size: 250,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            gapless: false,
            eyeStyle: const QrEyeStyle(
              color: Colors.green,
              eyeShape: QrEyeShape.circle,

            ),
            version: QrVersions.auto,
          ),

      ),
        ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: () {

           scanQR();
             //Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanQrPage()));
          }, child: Text("Scan Code"))
        ],
      ),
    );
  }


  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanCode = barcodeScanRes;
    });
  }
}
