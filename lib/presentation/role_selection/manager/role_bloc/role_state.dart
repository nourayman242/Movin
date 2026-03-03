import 'package:equatable/equatable.dart';

abstract class RoleState extends Equatable {
  const RoleState();

  @override
  List<Object?> get props => [];
}

class RoleInitial extends RoleState {}

class RoleLoading extends RoleState {}

class RoleSuccess extends RoleState {
  final String role;

  const RoleSuccess(this.role);

  @override
  List<Object?> get props => [role];
}

class RoleError extends RoleState {
  final String message;

  const RoleError(this.message);

  @override
  List<Object?> get props => [message];
}