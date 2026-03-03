import 'package:equatable/equatable.dart';

abstract class RoleEvent extends Equatable {
  const RoleEvent();

  @override
  List<Object?> get props => [];
}

class ChooseRoleEvent extends RoleEvent {
  final String role;

  const ChooseRoleEvent(this.role);

  @override
  List<Object?> get props => [role];
}