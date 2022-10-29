import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nft_domains_dapp/features/wallet/wallet_repository.dart';

import 'login/login.dart';

class App extends StatelessWidget {
  const App({super.key, required this.walletRepository});

  final WalletRepository walletRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: walletRepository,
        // TODO: will be AuthBloc
        child: AppView());
  }
}

class AppView extends StatelessWidget {
  AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: _buildTheme(),
      routerConfig: _router,
      title: "NFT Domains",
    );
  }

  final GoRouter _router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );

  ThemeData _buildTheme() {
    final baseTheme = ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
    );
    return baseTheme.copyWith(
      // TODO: Handle fonts dependency
      textTheme: GoogleFonts.robotoTextTheme(baseTheme.textTheme),
    );
  }
}
