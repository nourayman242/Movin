import 'package:flutter/material.dart';
import '../../../app_theme.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.large),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppWidgets.logo(LogoKeys.logoKey, size: 140),
              AppWidgets.verticalSpace(30),
              AppWidgets.heading("Reset Password"),
              AppWidgets.verticalSpace(10),
              AppWidgets.subtitle("Enter and confirm your new password"),
              AppWidgets.verticalSpace(40),
              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscureNew,
                decoration: AppInputDecoration.rounded(
                  hintText: "New Password",
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: _obscureNew
                      ? Icons.visibility_off
                      : Icons.visibility,
                  onSuffixTap: () {
                    setState(() {
                      _obscureNew = !_obscureNew;
                    });
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a new password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              AppWidgets.verticalSpace(20),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirm,
                decoration: AppInputDecoration.rounded(
                  hintText: "Confirm Password",
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: _obscureConfirm
                      ? Icons.visibility_off
                      : Icons.visibility,
                  onSuffixTap: () {
                    setState(() {
                      _obscureConfirm = !_obscureConfirm;
                    });
                  },
                ),
                validator: (value) {
                  if (value != _newPasswordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              AppWidgets.verticalSpace(40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: AppButtons.primary,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password reset successfully!"),
                        ),
                      );
                      Navigator.popUntil(context, (route) => route.isFirst);
                    }
                  },
                  child: const Text("Reset Password"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
