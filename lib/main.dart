import 'package:flutter/material.dart';
import 'package:nft_domains_dapp/features/wallet/wallet_repository.dart';

import 'app/app.dart';

void main() {
  runApp(App(
    walletRepository: WalletRepository(),
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
