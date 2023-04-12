import 'package:flutter/material.dart';
import 'package:kushneta/FloatBotton/QrScanner.dart';

class Home extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "KUShneta",
          style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
        ),
      ),
    
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Qr()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
