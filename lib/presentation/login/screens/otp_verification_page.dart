import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';
import 'package:movin/presentation/login/cubit/otp_cubit.dart';
import 'package:movin/presentation/login/cubit/otp_state.dart';
import '../../../app_theme.dart';
import 'reset_password_page.dart';

class OTPVerificationPage extends StatefulWidget {
  final String email;
  const OTPVerificationPage({super.key, required this.email});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  String get _otp => _otpControllers.map((c) => c.text).join().trim();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OtpCubit>(
      create: (_) => getIt<OtpCubit>(),
      child: _OTPVerificationView(
        email: widget.email,
        otpControllers: _otpControllers,
        focusNodes: _focusNodes,
        otp: _otp,
      ),
    );
  }
}

class _OTPVerificationView extends StatelessWidget {
  final String email;
  final List<TextEditingController> otpControllers;
  final List<FocusNode> focusNodes;
  final String otp;

  const _OTPVerificationView({
    required this.email,
    required this.otpControllers,
    required this.focusNodes,
    required this.otp,
  });

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppWidgets.logo(LogoKeys.logoKey, size: 140),
            AppWidgets.verticalSpace(30),
            AppWidgets.heading("Verify OTP"),
            AppWidgets.verticalSpace(10),
            Text(
              "Enter the 6-digit code sent to $email",
              style: AppTextStyles.subHeading,
              textAlign: TextAlign.center,
            ),
            AppWidgets.verticalSpace(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: boxSize,
                  height: boxSize * 1.2,
                  child: TextField(
                    controller: otpControllers[index],
                    focusNode: focusNodes[index],
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
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.navyLight),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.gold, width: 2),
                      ),
                    ),
                    onChanged: (value) => _onChanged(value, index),
                  ),
                );
              }),
            ),
            AppWidgets.verticalSpace(50),
            BlocConsumer<OtpCubit, OtpState>(
              listener: (context, state) {
                if (state is OtpSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordPage(email: email),
                    ),
                  );
                } else if (state is OtpFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
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
                      if (otp.length == 6) {
                        context.read<OtpCubit>().verifyOtp(
                          email: email,
                          otp: otp,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please enter all 6 digits")),
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
    );
  }
}
