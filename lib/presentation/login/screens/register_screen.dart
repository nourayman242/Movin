import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';
import 'package:movin/domain/entities/register_entity.dart';
import 'package:movin/domain/repositories/register_repository.dart';

class RegisterScareen extends StatefulWidget {
  const RegisterScareen({super.key});

  @override
  State<RegisterScareen> createState() => _RegisterScareenState();
}

class _RegisterScareenState extends State<RegisterScareen> {
  bool obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameValue = TextEditingController();
  final TextEditingController userValue = TextEditingController();
  final TextEditingController phoneValue = TextEditingController();
  final TextEditingController passValue = TextEditingController();

  final repo = getIt<RegisterRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                AppWidgets.logo(LogoKeys.logoKey, size: 250),
                AppWidgets.heading('Welcome to Movin'),
                AppWidgets.subtitle(
                  'Your journey to the perfect property starts here',
                ),
                AppWidgets.verticalSpace(AppSpacing.large),

                Text('Full Name', style: AppTextStyles.label),
                TextFormField(
                  controller: nameValue,
                  cursorColor: AppColors.gold,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Full name required'
                      : null,
                  decoration: AppInputDecoration.rounded(
                    hintText: 'Enter your full name',
                    prefixIcon: Icons.person_2_outlined,
                  ),
                ),
                AppWidgets.verticalSpace(AppSpacing.medium),

                Text('Email', style: AppTextStyles.label),
                TextFormField(
                  controller: userValue,
                  cursorColor: AppColors.gold,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email required';
                    } else if (!value.contains('@')) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppInputDecoration.rounded(
                    hintText: 'Enter your email',
                    prefixIcon: Icons.email_outlined,
                  ),
                ),
                AppWidgets.verticalSpace(AppSpacing.medium),

                Text('Phone Number', style: AppTextStyles.label),
                TextFormField(
                  controller: phoneValue,
                  cursorColor: AppColors.gold,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Phone required' : null,
                  keyboardType: TextInputType.phone,
                  decoration: AppInputDecoration.rounded(
                    hintText: 'Enter your phone number',
                    prefixIcon: Icons.call_outlined,
                  ),
                ),
                AppWidgets.verticalSpace(AppSpacing.medium),

                Text('Password', style: AppTextStyles.label),
                TextFormField(
                  controller: passValue,
                  cursorColor: AppColors.gold,
                  obscureText: obscureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password required';
                    } else if (value.length < 8) {
                      return 'At least 8 characters';
                    } else if (!value.contains(RegExp(r'[A-Z]'))) {
                      return 'Add at least one uppercase letter';
                    }
                    return null;
                  },
                  decoration: AppInputDecoration.rounded(
                    hintText: 'Create a password',
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onSuffixTap: () {
                      setState(() => obscureText = !obscureText);
                    },
                  ),
                ),
                AppWidgets.verticalSpace(AppSpacing.large),

                ///linking
                ElevatedButton(
                  style: AppButtons.primary,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final user = RegisterEntity(
                        username: nameValue.text.trim(),
                        email: userValue.text.trim(),
                        phone: phoneValue.text.trim(),
                        password: passValue.text,
                      );
                      try {
                        await repo.registerUser(user);
                        await SharedHelper.setLoggedIn(true);

                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registered successfully')),
                        );
                        Navigator.pushReplacementNamed(context, '/role').then((
                          _,
                        ) {
                          nameValue.clear();
                          userValue.clear();
                          phoneValue.clear();
                          passValue.clear();
                        });
                      } catch (e, st) {
                        if (!context.mounted) return;
                        print('Exception: $e');
                        print('StackTrace: $st');
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }
                  },
                  child: const Text(
                    'Create Account',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                AppWidgets.verticalSpace(AppSpacing.large),

                Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'By continuing, you agree to our ',
                            style: AppTextStyles.smallText,
                          ),
                          TextButton(
                            onPressed: () {},
                            style: AppButtons.text,
                            child: const Text('Terms of Service'),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('and ', style: AppTextStyles.smallText),
                          TextButton(
                            onPressed: () {},
                            style: AppButtons.text,
                            child: const Text('Privacy Policy'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
