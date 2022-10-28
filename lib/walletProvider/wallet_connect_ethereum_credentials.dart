import 'package:web3dart/src/crypto/secp256k1.dart';
import 'dart:typed_data';

import 'package:web3dart/web3dart.dart';

class EthereumCredentials implements Credentials {
  @override
  Future<EthereumAddress> extractAddress() {
    // TODO: implement extractAddress
    throw UnimplementedError();
  }

  @override
  // TODO: implement isolateSafe
  bool get isolateSafe => throw UnimplementedError();

  @override
  Future<Uint8List> sign(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement sign
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> signPersonalMessage(Uint8List payload, {int? chainId}) {
    // TODO: implement signPersonalMessage
    throw UnimplementedError();
  }

  @override
  Future<MsgSignature> signToSignature(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToSignature
    throw UnimplementedError();
  }
}
