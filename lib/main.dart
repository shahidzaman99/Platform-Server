import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Platform Server',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 1. MethodChannel with unique name
  static const MethodChannel _methodChannel =
  MethodChannel('platformchannel.companyname.com/deviceinfo');

  // 2. Variable to store device info
  String _deviceInfo = 'Fetching device info...';

  // 3. Async method to get device info from native platform
  Future<void> _getDeviceInfo() async {
    String deviceInfo;
    try {
      deviceInfo = await _methodChannel.invokeMethod('getDeviceInfo');
    } on PlatformException catch (e) {
      deviceInfo = "Failed to get device info: '${e.message}'.";
    }

    // 4. Update UI
    setState(() {
      _deviceInfo = deviceInfo;
    });
  }

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platform Server'),
      ),
      body: SafeArea(
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          title: const Text(
            'Device Info:',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            _deviceInfo,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
