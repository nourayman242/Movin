import 'package:equatable/equatable.dart';
import 'package:movin/data/api_services/user_response.dart';


abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class AuthInitial extends AuthState {}

/// Loading state
class AuthLoading extends AuthState {}

/// Success state
class AuthSuccess extends AuthState {
  final String token;
  final UserResponse user;
  const AuthSuccess(this.token, this.user);

  @override
  List<Object?> get props => [token,user];
}

/// Error state
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
