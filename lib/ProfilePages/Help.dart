import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '1. How can I rent a bike?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'To rent a bike, follow these steps:\n\n'
                '1. Open the app and navigate to the map view.\n'
                '2. Find a nearby bike station on the map.\n'
                '3. Tap on the station to view available bikes.\n'
                '4. Select a bike and click the "Rent" button.\n'
                '5. Scan the QR code on the bike to unlock it.\n'
                '6. Enjoy your ride!',
              ),
              SizedBox(height: 16),
              Text(
                '2. How can I report a problem with a bike?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'If you encounter any issues with a bike, such as '
                'mechanical problems or damage, please contact our '
                'customer support team at support@example.com or '
                'call us at +1-123-456-7890.',
              ),
              SizedBox(height: 16),
              Text(
                '3. How can I find bike stations near me?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'You can find bike stations near your location by '
                'opening the app and navigating to the map view. '
                'The map will display nearby bike stations as markers '
                'and provide information about the number of available '
                'bikes at each station.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
