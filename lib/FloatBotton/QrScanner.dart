import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Qr extends StatefulWidget {
  const Qr({Key? key}) : super(key: key);

  @override
  State<Qr> createState() => _QrState();
}

class _QrState extends State<Qr> {

  final qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;

  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }
  @override
  void reassemble() async{
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children:<Widget> [
          buildQRView(context),
        ],
      ),
    ),
  );
  Widget buildQRView(BuildContext context) => QRView(
    key: qrKey,
    onQRViewCreated : onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderRadius: 10,
      borderLength: 20,
      borderWidth: 10,
      borderColor: Colors.grey,
      cutOutSize: MediaQuery.of(context).size.width * 0.8,
    ),
  );
  void onQRViewCreated(QRViewController controller) {
    setState (() => this.controller= controller );
  }
}
