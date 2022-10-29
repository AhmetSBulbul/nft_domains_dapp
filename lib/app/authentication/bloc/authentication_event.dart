part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// class AuthenticationConnectRequested extends AuthenticationEvent {}

class AuthenticationConnectSucceeded extends AuthenticationEvent {
  const AuthenticationConnectSucceeded(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

// class AuthenticationStatusChanged extends AuthenticationEvent {
//   const AuthenticationStatusChanged(this.status);

//   final AuthenticationStatus status;

//   @override
//   List<Object> get props => [status];
// }
