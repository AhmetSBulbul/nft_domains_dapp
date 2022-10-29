import 'package:flutter/material.dart';
import 'package:nft_domains_dapp/features/wallet/wallet.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, guest }

class AuthInfo extends ChangeNotifier {
  AuthInfo({required WalletRepository walletRepository})
      : _walletRepository = walletRepository {
    _walletRepository.walletConnector.registerListeners(
      onConnect: (status) {
        // _user = User(status.accounts[0]);
        _status = AuthenticationStatus.authenticated;
        notifyListeners();
      },
      onSessionUpdate: (response) {
        // TODO: Implement it
      },
      onDisconnect: () {
        _status = AuthenticationStatus.unauthenticated;
        notifyListeners();
      },
    );
  }

  final WalletRepository _walletRepository;

  AuthenticationStatus get status => _status;
  AuthenticationStatus _status = AuthenticationStatus.unknown;

  void loginAsGuest() {
    _status = AuthenticationStatus.guest;
    notifyListeners();
  }
}
