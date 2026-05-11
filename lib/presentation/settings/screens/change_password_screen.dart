import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';
import 'package:movin/domain/repositories/change_password_repository.dart';
import 'package:movin/presentation/settings/managers/change_password_cubit.dart';
import 'package:movin/presentation/settings/managers/change_password_state.dart';
import '../../../app_theme.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ChangePasswordCubit(getIt<ChangePasswordRepository>()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSpacing.large),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppWidgets.logo(LogoKeys.logoKey, size: 140),
                AppWidgets.verticalSpace(30),
                AppWidgets.heading("Change Password"),
                AppWidgets.verticalSpace(10),
                AppWidgets.subtitle(
                    "Enter your old password and choose a new one"),
                AppWidgets.verticalSpace(40),

                // ── Old Password ──────────────────────────────────────
                TextFormField(
                  controller: _oldPasswordController,
                  obscureText: _obscureOld,
                  decoration: AppInputDecoration.rounded(
                    hintText: "Old Password",
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: _obscureOld
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onSuffixTap: () =>
                        setState(() => _obscureOld = !_obscureOld),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your old password";
                    }
                    return null;
                  },
                ),
                AppWidgets.verticalSpace(20),

                // ── New Password ──────────────────────────────────────
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: _obscureNew,
                  decoration: AppInputDecoration.rounded(
                    hintText: "New Password",
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: _obscureNew
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onSuffixTap: () =>
                        setState(() => _obscureNew = !_obscureNew),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a new password";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    if (value == _oldPasswordController.text) {
                      return "New password must differ from old password";
                    }
                    return null;
                  },
                ),
                AppWidgets.verticalSpace(20),

                // ── Confirm Password ──────────────────────────────────
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirm,
                  decoration: AppInputDecoration.rounded(
                    hintText: "Confirm Password",
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: _obscureConfirm
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onSuffixTap: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                  validator: (value) {
                    if (value != _newPasswordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                AppWidgets.verticalSpace(40),

                // ── Submit Button ─────────────────────────────────────
                BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                  listener: (context, state) {
                    if (state is ChangePasswordSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                      Navigator.pop(context);
                    } else if (state is ChangePasswordFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ChangePasswordLoading) {
                      return const Center(
                          child: CircularProgressIndicator());
                    }
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: AppButtons.primary,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<ChangePasswordCubit>()
                                .changePassword(
                                  oldPassword: _oldPasswordController
                                      .text
                                      .trim(),
                                  newPassword: _newPasswordController
                                      .text
                                      .trim(),
                                );
                          }
                        },
                        child: const Text("Change Password"),
                      ),
                    );
                  },
                ),
                AppWidgets.verticalSpace(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}