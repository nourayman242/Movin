abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  final String message;
  ChangePasswordSuccess({this.message = "Password changed successfully"});
}

class ChangePasswordFailure extends ChangePasswordState {
  final String error;
  ChangePasswordFailure(this.error);
}