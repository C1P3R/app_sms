import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_receiver/sms_receiver.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SmsDisplayScreen(),
    );
  }
}

class SmsDisplayScreen extends StatefulWidget {
  @override
  _SmsDisplayScreenState createState() => _SmsDisplayScreenState();
}

class _SmsDisplayScreenState extends State<SmsDisplayScreen> {
  String _message = 'Waiting for messages...';
  SmsReceiver? _smsReceiver;

  @override
  void initState() {
    super.initState();
    _smsReceiver = SmsReceiver(_onSmsReceived);
    _requestSmsPermission();
  }

  void _requestSmsPermission() async {
    if (await Permission.sms.request().isGranted) {
      _smsReceiver?.startListening();
    }
  }

  void _onSmsReceived(String? message) {
    setState(() {
      _message = message ?? 'No message received';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS Display App'),
      ),
      body: Center(
        child: Text(_message),
      ),
    );
  }
}
