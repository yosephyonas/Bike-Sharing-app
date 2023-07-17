// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  double availableBalance = 100.0;
  List<String> purchasedPackages = [];

  void buyPackage(double amount) {
    setState(() {
      availableBalance -= amount;

      int distance = (amount / 5).floor();

      purchasedPackages.add(
          '\$${amount.toStringAsFixed(2)} Kushneta Package (${distance}km)');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Available Balance:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${availableBalance.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const Divider(
              height: 32,
              thickness: 2,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Buy Kushneta Package'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildPackageButton(5),
                        buildPackageButton(10),
                        buildPackageButton(15),
                        buildPackageButton(20),
                        buildPackageButton(25),
                        // Add more package buttons as needed
                      ],
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 16.0),
              ),
              child: const Text(
                'Top Up',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Divider(
              height: 32,
              thickness: 2,
            ),
            const Text(
              'Purchased Packages:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              children: purchasedPackages
                  .map(
                    (package) => Text(
                      package,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPackageButton(double amount) {
    int distance = (amount / 5).floor();
    return ElevatedButton(
      onPressed: () {
        buyPackage(amount);
        Navigator.pop(context); // Close the dialog after purchase
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        '${amount.toStringAsFixed(2)} Birr  Kushneta Package (${distance}km)',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
