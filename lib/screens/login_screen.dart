import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
          child: ElevatedButton(
        child: const Text("Connect With Metamask"),
        onPressed: () async {
          // await qrCodeModal.connect(context, chainId: 80001);
          // loginUsingMetamask(context);
        },
      )),
    );
  }
}
