import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

  //static const _channel = MethodChannel('com.example.volume_button_handler');

  @override
  void initState() {
    super.initState();
   // _channel.setMethodCallHandler(_onMethodCall);
   const channel = MethodChannel('com.example.volume_button_handler');
    channel.setMethodCallHandler((call) async {
    if (call.method == 'volumeUpPressed') {
      debugPrint("Flutter received volumeUpPressed!");
    _scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(content: Text('Volume Up Pressed!')),
  );


    //   Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (_) => const ContactScreen()),
    // );
      //_openContactsScreen();
    } else if (call.method == 'volumeDownPressed') {
      debugPrint("Flutter received volumeDownPressed!");
       _scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(content: Text('Volume Down Pressed!')),
  );

    }
  });
  }

  Future<void> _onMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'volumeUpPressed':
       // _openContactsScreen();
        debugPrint('pressed button-------');
        break;
      case 'volumeDownPressed':
      
        break;
      default:
        break;
    }
  }
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
       scaffoldMessengerKey: _scaffoldMessengerKey,
      home: Scaffold(
        appBar: AppBar(title: const Text('Volume Button Handler')),
        body: const Center(child: Text('Press Volume Buttons,')),
      ),
    );
  }
}

  // void _openContactsScreen() {
  //   // This could be a navigation to a contact screen within your app,
  //   // or launch the native contact app if you prefer.
  //   // For example, to open a route in your Flutter app:
  //    print("About to push ContactScreen...");
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (_) => ContactScreen()),
  //   );
  // }

 

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: const Center(child: Text('Contact List or similar...')),
    );
  }
}
