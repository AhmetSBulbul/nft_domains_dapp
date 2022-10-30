import 'package:nft_domains_dapp/features/domain_service/contract/Domains.g.dart';
import 'package:web3dart/web3dart.dart';

class DomainService {
  DomainService(
      {required this.contractProvider, required this.contractAddress});
  final Domains contractProvider;
  final String contractAddress;

  Future<String> register(Credentials credentials, String domain) async {
    try {
      final BigInt price = domain.length == 3
          ? BigInt.from(5)
          : domain.length == 4
              ? BigInt.from(3)
              : BigInt.from(1);
      final result = await contractProvider.register(domain,
          credentials: credentials,
          transaction: Transaction(
            to: EthereumAddress.fromHex(contractAddress),
            value: EtherAmount.fromUnitAndValue(EtherUnit.finney, price),
          ));

      return result;
    } catch (e) {
      return e.toString();
    }
  }
}
