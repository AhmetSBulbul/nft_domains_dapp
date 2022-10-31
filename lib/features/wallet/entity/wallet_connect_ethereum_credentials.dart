import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/crypto.dart';
import 'dart:typed_data';

import 'package:web3dart/web3dart.dart';

class WalletConnectEthereumCredentials extends CustomTransactionSender {
  WalletConnectEthereumCredentials({required this.provider});

  final EthereumWalletConnectProvider provider;

  @override
  Future<EthereumAddress> extractAddress() => Future(
      () => EthereumAddress.fromHex(provider.connector.session.accounts.first));

  @override

  /// Signs the given transaction with the metamask wallet
  /// Opens the metamask app and asks the user to sign the transaction
  /// Returns the signed transaction
  /// Throws an exception if the user rejects the transaction
  /// Throws an exception if the user is not connected to the wallet
  Future<String> sendTransaction(Transaction transaction) async {
    final sender = await extractAddress();
    final hash = provider.sendTransaction(
      from: sender.hex,
      to: transaction.to?.hex,
      data: transaction.data,
      gas: transaction.maxGas,
      gasPrice: transaction.gasPrice?.getInWei,
      value: transaction.value?.getInWei,
      nonce: transaction.nonce,
    );

    final String url = provider.connector.session.toUri();
    await launchUrlString(url, mode: LaunchMode.externalApplication);

    final String signedHash = await hash;

    return signedHash;
  }

  @override
  Future<MsgSignature> signToSignature(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToSignature
    throw UnimplementedError();
  }
}
