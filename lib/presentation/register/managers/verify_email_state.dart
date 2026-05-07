
abstract class VerifyEmailState {}

class VerifyEmailInitial extends VerifyEmailState {}

class VerifyEmailLoading extends VerifyEmailState {}

class VerifyEmailSuccess extends VerifyEmailState {}

class VerifyEmailError extends VerifyEmailState {
  final String message;

  VerifyEmailError(this.message);
}
class ResendOtpLoading extends VerifyEmailState {}

class ResendOtpSuccess extends VerifyEmailState {
  final String message;

  ResendOtpSuccess(this.message);
}

class ResendOtpError extends VerifyEmailState {
  final String message;

  ResendOtpError(this.message);
}