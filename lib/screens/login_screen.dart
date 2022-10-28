import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nft_domains_dapp/contracts/Domains.g.dart';
import 'package:web3dart/web3dart.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _getAddress() async {
    const apiUrl = "https://matic-mumbai.chainstacklabs.com";
    final address =
        EthereumAddress.fromHex("0x9Bd1110435cA360E6e999ba5b46B87421aD3D4b7");

    var httpClient = Client();
    var ethClient = Web3Client(apiUrl, httpClient);
    final stub = Domains(address: address, client: ethClient);
    final result = await stub.getOwner('ahmets');
    print(result);
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
          await _getAddress();
          // await qrCodeModal.connect(context, chainId: 80001);
          // loginUsingMetamask(context);
        },
      )),
    );
  }
}
