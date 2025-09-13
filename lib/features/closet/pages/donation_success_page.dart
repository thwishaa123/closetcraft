import 'package:flutter/material.dart';

class DonationSuccessPage extends StatelessWidget {
  final String? referenceId;
  final String? method;
  const DonationSuccessPage({super.key, this.referenceId, this.method});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Successful'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 24),
              Text('Thank You for Your Donation!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              if (method == 'Pick at Doorstep')
                const Text('We will reach out to you soon with pickup details.',
                    textAlign: TextAlign.center)
              else if (method == 'Drop Yourself')
                Text(
                  'Please deliver to the NGO address. Reference ID: ${referenceId ?? 'DON-XXXX'}.',
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
