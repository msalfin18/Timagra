import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timagra_new/view/homepage.dart';

import 'nointernet.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool hasInternet = true;
  late Connectivity _connectivity;
  late Stream<ConnectivityResult> _connectivityStream;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
  _connectivityStream = _connectivity.onConnectivityChanged.map((event) => event.first);

    _listenToConnectivity();
    _requestPermissions();
  }

  // 🛠 Listen to connectivity changes
  void _listenToConnectivity() {
    _connectivityStream.listen((ConnectivityResult result) {
      setState(() {
        hasInternet = result != ConnectivityResult.none;
      });

      // ✅ Navigate based on internet status
      if (hasInternet) {
        _navigateToHome();
      } else {
        _navigateToNoInternet();
      }
    });
  }

  // 📡 Navigate to Home if internet is available
  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && hasInternet) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      }
    });
  }

  //  Navigate to NoInternetPage if no internet
  void _navigateToNoInternet() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && !hasInternet) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NoInternetPage()),
        );
      }
    });
  }

  // ✅ Request required permissions
  _requestPermissions() async {
    await [
      Permission.location,
      Permission.camera,
      Permission.phone,
      Permission.locationAlways,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/app_icon.png', height: 150, width: 150),
            SizedBox(height: 20),
            // Text("Checking internet connection..."),
          ],
        ),
      ),
    );
  }
}
