import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.address);
  final String address;

  @override
  List<Object?> get props => [address];

  static const empty = User('-');
  static const guest = User('guest');
}
