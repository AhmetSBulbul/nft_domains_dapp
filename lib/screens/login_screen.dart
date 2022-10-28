import 'package:flutter/material.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_qrcode_modal_dart/walletconnect_qrcode_modal_dart.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Create a connector
  final qrCodeModal = WalletConnectQrCodeModal(
    connector: WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        // <-- Meta data of your app appearing in the wallet when connecting
        name: 'QRCodeModalExampleApp',
        description: 'WalletConnect Developer App',
        url: 'https://walletconnect.org',
        icons: [
          'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
        ],
      ),
    ),
  );
  @override
  void initState() {
    super.initState();
    // Subscribe to events
    qrCodeModal.registerListeners(
      onConnect: (session) => print('Connected: $session'),
      onSessionUpdate: (response) => print('Session updated: $response'),
      onDisconnect: () => print('Disconnected'),
    );
  }

  @override
  void dispose() {
    // connector.killSession();
    qrCodeModal.killSession();
    super.dispose();
  }

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
          await qrCodeModal.connect(context, chainId: 80001);
          // loginUsingMetamask(context);
        },
      )),
    );
  }
}
