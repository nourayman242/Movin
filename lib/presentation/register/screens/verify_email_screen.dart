
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_theme.dart';

import '../managers/verify_email_bloc.dart';
import '../managers/verify_email_event.dart';
import '../managers/verify_email_state.dart';

import '../widgets/otp_input.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;

  const VerifyEmailScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerifyEmailScreen> createState() =>
      _VerifyEmailScreenState();
}

class _VerifyEmailScreenState
    extends State<VerifyEmailScreen> {

  String otp = '';
  Timer? timer;

  int remainingSeconds = 300;
  bool get isOtpValid => otp.length == 6;
  bool get canResend => remainingSeconds == 0;
  @override
  void initState() {
    super.initState();

    startTimer();
  }
  void startTimer() {

    timer?.cancel();

    setState(() {
      remainingSeconds = 300;
    });

    timer = Timer.periodic(
      const Duration(seconds: 1),
          (_) {

        if (remainingSeconds == 0) {

          timer?.cancel();

        } else {

          setState(() {
            remainingSeconds--;
          });
        }
      },
    );
  }
  String formatTime(int seconds) {

    final minutes = seconds ~/ 60;

    final secs = seconds % 60;

    return "$minutes:${secs.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primaryNavy,

        title: const Text(
          "Verify Email",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 30),

            Text(
              "Enter the 6-digit code sent to",
              style: AppTextStyles.subHeading,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 5),

            Text(
              widget.email,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.navyDark,
              ),
            ),

            const SizedBox(height: 40),

            OTPInput(
              onChanged: (value) {

                setState(() {
                  otp = value;
                });
              },
            ),

            const SizedBox(height: 20),

            if (!canResend)
              Text(
                "Resend OTP in ${formatTime(remainingSeconds)}",
                style: const TextStyle(
                  color: AppColors.navyDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            if (canResend)
              TextButton(
                onPressed: () {

                  context.read<VerifyEmailBloc>().add(
                    ResendOtpEvent(
                      email: widget.email,
                    ),
                  );

                  startTimer();
                },

                child: const Text(
                  "Resend OTP",

                  style: TextStyle(
                    color: AppColors.gold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            const SizedBox(height: 40),

            BlocConsumer<
                VerifyEmailBloc,
                VerifyEmailState>(
              listener: (context, state) {
                if (state is VerifyEmailSuccess) {

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/role',
                        (_) => false,
                  );
                }

                if (state is VerifyEmailError) {

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }

                if (state is ResendOtpSuccess) {

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }

                if (state is ResendOtpError) {

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },

              builder: (context, state) {

                final loading =
                state is VerifyEmailLoading;

                return SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      isOtpValid
                          ? AppColors.primaryNavy
                          : AppColors.grey,

                      foregroundColor: Colors.white,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(30),
                      ),
                    ),

                    onPressed:
                    isOtpValid && !loading
                        ? () {

                      context
                          .read<VerifyEmailBloc>()
                          .add(
                        SubmitOtpEvent(
                          email: widget.email,
                          otp: otp,
                        ),
                      );
                    }
                        : null,

                    child: loading
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      "Verify",

                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}