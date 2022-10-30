import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nft_domains_dapp/features/domain_service/contract/Domains.g.dart';
import 'package:nft_domains_dapp/features/domain_service/domain_service.dart';
import 'package:nft_domains_dapp/features/wallet/wallet_repository.dart';
import 'package:web3dart/web3dart.dart';

import 'app/app.dart';

void main() {
  const apiUrl = "https://matic-mumbai.chainstacklabs.com";
  final address =
      EthereumAddress.fromHex("0x9Bd1110435cA360E6e999ba5b46B87421aD3D4b7");

  final httpClient = Client();
  final ethClient = Web3Client(apiUrl, httpClient);

  runApp(App(
    walletRepository: WalletRepository(),
    domainService: DomainService(
        contractAddress: address.hex,
        contractProvider:
            Domains(address: address, client: ethClient, chainId: 80001)),
  ));
}

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: '/login',
//       routes: {
//         '/login': (context) => const LoginScreen(),
//         '/home': (context) => const HomeScreen(),
//       },
//     );
//   }
// }
