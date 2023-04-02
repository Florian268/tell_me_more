import 'package:flutter/material.dart';
import 'package:tell_me_more/models/exhibit.dart';
import 'package:tell_me_more/views/exhibit.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';

class ScannerView extends StatefulWidget  {
  const ScannerView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late Exhibit exhibit;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    // bug of screen not loading
    if(controller != null && mounted){
      controller!.pauseCamera();
      controller!.resumeCamera();
    }

    // issue with passing data over
    if(result != null) {
      // exhibit = Exhibit('Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}');
      exhibit = Exhibit('${result!.code}');

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (BuildContext context) => ExhibitView(),
          settings: RouteSettings(
            arguments: exhibit,),));
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner'),
      ),
      body: Column(

        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
    ]
     )
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}