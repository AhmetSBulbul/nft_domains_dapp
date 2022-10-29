import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nft_domains_dapp/features/authentication/authentication_repository.dart';
import 'package:nft_domains_dapp/features/wallet/wallet.dart';

import '../../../features/authentication/entity/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required WalletRepository walletRepository,
  })  : _walletRepository = walletRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationConnectSucceeded>(_onAuthenticationConnectSucceed);
    _walletRepository.walletConnector.registerListeners(
      onConnect: (status) {
        add(AuthenticationConnectSucceeded(User(status.accounts[0])));
      },
    );
  }

  final WalletRepository _walletRepository;

  Future<void> _onAuthenticationConnectSucceed(
    AuthenticationConnectSucceeded event,
    Emitter<AuthenticationState> emit,
  ) async {
    return emit(AuthenticationState.authenticated(event.user));
  }
}
