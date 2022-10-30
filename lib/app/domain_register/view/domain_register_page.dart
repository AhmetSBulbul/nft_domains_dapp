import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft_domains_dapp/features/domain_service/domain_service.dart';
import 'package:nft_domains_dapp/features/wallet/wallet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:web3dart/web3dart.dart';

class DomainRegisterPage extends StatefulWidget {
  const DomainRegisterPage({super.key});

  @override
  State<DomainRegisterPage> createState() => _DomainRegisterPageState();
}

class _DomainRegisterPageState extends State<DomainRegisterPage> {
  String _domainName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Domain Register'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const Expanded(
                child: Center(child: Text("Feed")),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Domain Name",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _domainName = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  ElevatedButton(
                    onPressed: _domainName.isNotEmpty
                        ? () async {
                            print("Process Started");
                            final WalletRepository wallet =
                                RepositoryProvider.of<WalletRepository>(
                                    context);
                            final Credentials credentials =
                                wallet.getCredentials(wallet.ethProvider);
                            final DomainService service =
                                RepositoryProvider.of<DomainService>(context);

                            final Future<String> result =
                                service.register(credentials, _domainName);
                            await launchUrlString(
                                wallet.walletConnector.session.toUri(),
                                mode: LaunchMode.externalApplication);
                            result.then((value) {
                              print(value);
                            });
                            setState(() {
                              _domainName = "";
                            });
                          }
                        : null,
                    child: const Text("Register"),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
