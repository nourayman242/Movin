
abstract class VerifyEmailEvent {}

class SubmitOtpEvent extends VerifyEmailEvent {
  final String email;
  final String otp;

  SubmitOtpEvent({
    required this.email,
    required this.otp,
  });
}
class ResendOtpEvent extends VerifyEmailEvent {
  final String email;

  ResendOtpEvent({
    required this.email,
  });
}