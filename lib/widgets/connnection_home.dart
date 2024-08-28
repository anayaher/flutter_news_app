import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/home_screen.dart';

class ConnectionHome extends StatefulWidget {
  const ConnectionHome({super.key});

  @override
  State<ConnectionHome> createState() => _ConnectionHomeState();
}

class _ConnectionHomeState extends State<ConnectionHome> {
  late StreamSubscription<ConnectivityResult> _subscription;
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();

    // Subscribe to connectivity changes
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        _connectivityResult = result;
      });

      if (result != ConnectivityResult.none) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });

    // Initial connectivity check
    _checkInitialConnectivity();
  }

  Future<void> _checkInitialConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = result;
    });
  }

  @override
  void dispose() {
    // Cancel the subscription when the widget is disposed
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _connectivityResult == ConnectivityResult.none
        ? OfflinePage(onRetry: _checkInitialConnectivity)
        : HomeScreen();
  }
}

class OfflinePage extends StatelessWidget {
  final VoidCallback onRetry;

  const OfflinePage({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offline')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off,
                size: 100,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 20),
              const Text(
                'No Internet Connection',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please check your connection and try again.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
