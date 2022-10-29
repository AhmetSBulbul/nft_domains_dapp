import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nft_domains_dapp/contracts/Domains.g.dart';
import 'package:nft_domains_dapp/features/wallet/entity/wallet_connect_ethereum_credentials.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
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

    final WalletConnect connector = WalletConnect(
        bridge: 'https://bridge.walletconnect.org',
        clientMeta: const PeerMeta(
            name: 'My App',
            description: 'An app for converting pictures to NFT',
            url: 'https://walletconnect.org',
            icons: [
              'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
            ]));

    try {
      var session = await connector.createSession(onDisplayUri: (uri) async {
        print(uri);
        await launchUrlString(uri, mode: LaunchMode.externalApplication);
      });
      final contractProvider =
          EthereumWalletConnectProvider(connector, chainId: 80001);
      final ethCredentials =
          WalletConnectEthereumCredentials(provider: contractProvider);
      print(session.toString());
      // connector.print(session.chainId);
      print(session.accounts.toString());
      connector.registerListeners(
        onConnect: (status) => print(status.toString()),
        onSessionUpdate: (response) => print(response.toString()),
        onDisconnect: () => print('disconnected'),
      );

      // connector.
      final result2 = await stub.register("mobilefirst",
          credentials: ethCredentials,
          transaction: Transaction(
            from: EthereumAddress.fromHex(session.accounts[0]),
            to: address,
            value:
                EtherAmount.fromUnitAndValue(EtherUnit.finney, BigInt.from(1)),
          ));
      // final result2 = await stub.register("testtest",
      //     credentials: credentials,
      //     transaction: Transaction(
      //         value: EtherAmount.fromUnitAndValue(
      //             EtherUnit.finney, BigInt.from(1))));
      // print(result2);

      print(result2);
      // connector.killSession();
    } catch (exp) {
      print("Error: ${exp.toString()}");
    }
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
