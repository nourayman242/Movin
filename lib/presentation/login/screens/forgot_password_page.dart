import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';

import '../../../app_theme.dart';
import '../../login/cubit/forget_pass_cubit.dart';
import '../../login/cubit/forget_pass_state.dart';
import 'otp_verification_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider<ForgotPasswordCubit>(
      create: (_) => getIt<ForgotPasswordCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              if (state is ForgotPasswordSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OTPVerificationPage(
                      email: _emailController.text.trim(),
                    ),
                  ),
                );
              }

              if (state is ForgotPasswordFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.08,
                        vertical: screenHeight * 0.04,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: screenHeight * 0.05),

                            Center(
                              child: AppWidgets.logo(
                                LogoKeys.logoKey,
                                size: screenHeight * 0.20,
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.04),

                            AppWidgets.heading("Forgot Password"),
                            AppWidgets.verticalSpace(screenHeight * 0.01),
                            AppWidgets.subtitle(
                              "Enter your email to receive an OTP",
                            ),

                            SizedBox(height: screenHeight * 0.05),

                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: AppInputDecoration.rounded(
                                hintText: "Enter your email",
                                prefixIcon: Icons.email_outlined,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter your email address";
                                }
                                if (!RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+',
                                ).hasMatch(value)) {
                                  return "Please enter a valid email address";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.08,
                      right: screenWidth * 0.08,
                      bottom: screenHeight * 0.04,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.065,
                      child: ElevatedButton(
                        style: AppButtons.primary,
                        onPressed: state is ForgotPasswordLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<ForgotPasswordCubit>()
                                      .sendOtp(
                                        _emailController.text.trim(),
                                      );
                                }
                              },
                        child: state is ForgotPasswordLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Send OTP"),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
