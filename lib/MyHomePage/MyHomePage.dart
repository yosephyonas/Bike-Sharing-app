import 'package:flutter/material.dart';
import 'package:kushneta/ProfilePages/Home.dart';
import 'package:kushneta/ProfilePages/Help.dart';
import 'package:kushneta/ProfilePages/ProfilePage.dart';
import 'package:kushneta/ProfilePages/Wallet.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex =0;

  final pages =[
     Home(),
     const Wallet(),
     const Help(),
      const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.lightBlue,
        iconSize: 25,
        currentIndex: currentIndex,
        onTap:(index) => setState(() => currentIndex= index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_center),
            label: 'Help',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Profile',
          )
        ],
      ),
    );
  }

}

