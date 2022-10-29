import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nft_domains_dapp/app/home/home.dart';
import 'package:nft_domains_dapp/features/wallet/wallet_repository.dart';
import 'package:provider/provider.dart';
import 'authentication/authentication.dart';
import 'login/login.dart';

class App extends StatelessWidget {
  App({super.key, required this.walletRepository})
      : _authInfo = AuthInfo(walletRepository: walletRepository);

  final WalletRepository walletRepository;
  final AuthInfo _authInfo;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: walletRepository,
        child: ChangeNotifierProvider<AuthInfo>.value(
          value: _authInfo,
          child: MaterialApp.router(
            theme: _buildTheme(),
            routerConfig: _router,
            title: "NFT Domains",
          ),
        ));
  }

  // ignore: prefer_final_fields
  late GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      )
    ],
    redirect: (context, state) {
      final bool isAuthenticated =
          _authInfo.status == AuthenticationStatus.authenticated;
      final bool loggingIn = state.subloc == '/login';
      if (!isAuthenticated) {
        return loggingIn ? null : '/login';
      }

      // if the user is logged in but still on the login page, send them to
      // the home page
      if (loggingIn) {
        return '/';
      }

      return null;
      // TODO: handle guest
    },
    refreshListenable: _authInfo,
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

// class AppView extends StatelessWidget {
//   AppView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       theme: _buildTheme(),
//       routerConfig: _router,
//       title: "NFT Domains",
//     );
//   }

//   final GoRouter _router = GoRouter(
//     initialLocation: '/login',
//     routes: [
//       GoRoute(
//         path: '/login',
//         builder: (context, state) => const LoginPage(),
//       ),
//     ],
//   );

//   ThemeData _buildTheme() {
//     final baseTheme = ThemeData(
//       brightness: Brightness.light,
//       useMaterial3: true,
//     );
//     return baseTheme.copyWith(
//       // TODO: Handle fonts dependency
//       textTheme: GoogleFonts.robotoTextTheme(baseTheme.textTheme),
//     );
//   }
// }
