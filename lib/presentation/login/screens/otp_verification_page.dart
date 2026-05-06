import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';
import 'package:movin/presentation/login/cubit/otp_cubit.dart';
import 'package:movin/presentation/login/cubit/otp_state.dart';
import 'package:movin/presentation/login/cubit/reset_pass_cubit.dart';
import '../../../app_theme.dart';
import 'reset_password_page.dart';

class OTPVerificationPage extends StatefulWidget {
  final String email;
  const OTPVerificationPage({super.key, required this.email});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  // Timer state
  static const int _resendCooldownSeconds = 300; // 5 minutes
  int _remainingSeconds = _resendCooldownSeconds;
  bool _canResend = false;
  Timer? _timer;

  String get _otp => _otpControllers.map((c) => c.text).join().trim();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _remainingSeconds = _resendCooldownSeconds;
      _canResend = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        timer.cancel();
        setState(() {
          _remainingSeconds = 0;
          _canResend = true;
        });
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  String get _timerText {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _otpControllers) c.dispose();
    for (var f in _focusNodes) f.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final boxSize = screenWidth * 0.12;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: BlocListener<OtpCubit, OtpState>(
        // Listen for BOTH verify and resend state changes at the top level
        listener: (context, state) {
          if (state is OtpSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => getIt<ResetPasswordCubit>(),
                  child: ResetPasswordPage(email: widget.email),
                ),
              ),
            );
          } else if (state is OtpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is OtpResendSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            _startTimer(); // restart the 5-min countdown
          } else if (state is OtpResendFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppWidgets.logo(LogoKeys.logoKey, size: 140),
              AppWidgets.verticalSpace(30),
              AppWidgets.heading("Verify OTP"),
              AppWidgets.verticalSpace(10),
              Text(
                "Enter the 6-digit code sent to ${widget.email}",
                style: AppTextStyles.subHeading,
                textAlign: TextAlign.center,
              ),
              AppWidgets.verticalSpace(40),

              // OTP input boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: boxSize,
                    height: boxSize * 1.2,
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: TextStyle(
                        fontSize: boxSize * 0.55,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryNavy,
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: AppColors.navyLight),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.gold,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) => _onChanged(value, index),
                    ),
                  );
                }),
              ),

              AppWidgets.verticalSpace(24),

              // ── Resend section ──
              BlocBuilder<OtpCubit, OtpState>(
                builder: (context, state) {
                  final isResendLoading = state is OtpResendLoading;

                  return Column(
                    children: [
                      if (!_canResend)
                        Text(
                          "Resend code in $_timerText",
                          style: AppTextStyles.subHeading.copyWith(
                            color: AppColors.primaryNavy.withOpacity(0.6),
                            fontSize: 13,
                          ),
                        )
                      else
                        isResendLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.gold,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  context
                                      .read<OtpCubit>()
                                      .resendOtp(email: widget.email);
                                },
                                child: Text(
                                  "Resend OTP",
                                  style: AppTextStyles.subHeading.copyWith(
                                    color: AppColors.gold,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                    ],
                  );
                },
              ),

              AppWidgets.verticalSpace(32),

              // ── Verify button ──
              BlocBuilder<OtpCubit, OtpState>(
                builder: (context, state) {
                  if (state is OtpLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: AppButtons.primary,
                      onPressed: () {
                        if (_otp.length == 6) {
                          context.read<OtpCubit>().verifyOtp(
                                email: widget.email,
                                otp: _otp,
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter all 6 digits"),
                            ),
                          );
                        }
                      },
                      child: const Text("Verify OTP"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}