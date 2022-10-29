import 'package:flutter/material.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';

import 'entity/wallet_connect_ethereum_credentials.dart';

class WalletRepository {
  final WalletConnect _walletConnector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
          name: 'Bulbul Name Service',
          description: 'An app for creating name services and minting nfts',
          url: 'https://ahmetsbulbul.com',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]));

  WalletConnect get walletConnector => _walletConnector;

  Future<void> connect(void Function(String) handleUri) async {
    if (!_walletConnector.connected) {
      try {
        // TODO: chainID
        final SessionStatus session = await _walletConnector.createSession(
            onDisplayUri: handleUri, chainId: 80001);
        debugPrint(
            "Session created with ${session.accounts[0]} on chain ${session.chainId}");
        // _walletConnector.a
      } catch (e) {
        // TODO: throw wallet connect error
        debugPrint(e.toString());
      }
    }
  }

  EthereumWalletConnectProvider get ethProvider {
    return EthereumWalletConnectProvider(_walletConnector, chainId: 80001);
  }

  Credentials getCredentials(EthereumWalletConnectProvider ethProvider) {
    // final ethProvider =
    //     EthereumWalletConnectProvider(_walletConnector, chainId: 80001);
    final ethCredentials =
        WalletConnectEthereumCredentials(provider: ethProvider);

    return ethCredentials;
  }

  Future<void> disconnect() async {
    if (_walletConnector.connected) {
      await _walletConnector.killSession();
    }
  }

  void dispose() => _walletConnector.close();
}
