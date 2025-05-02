import 'package:flutter/material.dart';
import 'service_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showGreetingPopup = true;

  // Simulated user data
  String userName = "Guest";
  String userImage = "assets/images/default_avatar.png"; // Placeholder avatar

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (_showGreetingPopup) {
        _showGreetingDialog();
      }
    });
  }

  void _showGreetingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Welcome!'),
        content: const Text(
          'This app helps you find electricians nearby or book products for repair easily!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _showGreetingPopup = false;
              });
              Navigator.of(context).pop();
            },
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }

  void _onServiceSelected(String service) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selected: $service')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electrician Finder'),
        centerTitle: false, // Align title to the left
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userName),
              accountEmail: Text('guest@example.com'), // For guest now
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(userImage),
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.build),
              title: const Text('My Bookings'),
              onTap: () {
                // Navigate to Bookings Page
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to Settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About App'),
              onTap: () {
                // Navigate to About Page
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Handle logout logic
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ServiceCard(
                    title: 'Book an Electrician',
                    imagePath: 'assets/images/electrician.png',
                    onTap: () => _onServiceSelected('Electrician'),
                  ),
                  ServiceCard(
                    title: 'Book a Product Repair',
                    imagePath: 'assets/images/repair.png',
                    onTap: () => _onServiceSelected('Product Repair'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
