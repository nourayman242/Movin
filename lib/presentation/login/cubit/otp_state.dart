

abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {
  final String message;

  OtpSuccess({this.message = "OTP verified successfully"});
}

class OtpFailure extends OtpState {
  final String message;
  OtpFailure(this.message);
}
