import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';
import 'package:movin/domain/entities/login_entity.dart';
import 'package:movin/domain/repositories/login_repositories.dart';
import 'package:movin/presentation/login/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userValue = TextEditingController();
  final TextEditingController passValue = TextEditingController();
  final repo = getIt<LoginRepository>();

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

                Text('Email', style: AppTextStyles.label),
                TextFormField(
                  controller: userValue,
                  cursorColor: AppColors.gold,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!value.contains('@')) {
                      return 'Enter a valid email';
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

                Text('Password', style: AppTextStyles.label),
                TextFormField(
                  controller: passValue,
                  cursorColor: AppColors.gold,
                  obscureText: obscureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  decoration: AppInputDecoration.rounded(
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onSuffixTap: () {
                      setState(() => obscureText = !obscureText);
                    },
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgotpassword');
                    },
                    style: AppButtons.text,
                    child: const Text('Forgot Password?'),
                  ),
                ),
                AppWidgets.verticalSpace(AppSpacing.medium),

                ///////////linking
                ElevatedButton(
                  style: AppButtons.primary,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(context, '/role');
                        final email = userValue.text.trim();
                        final password = passValue.text.trim();

                        final entity = LoginEntity(
                          email: email,
                          password: password,
                        );

                        try {
                          final response = await repo.loginUser(entity);

                          await SharedHelper.saveToken(response.token);
                          await SharedHelper.setLoggedIn(true);

                          if (!context.mounted) return;

                          Navigator.pushReplacementNamed(context, '/role').then((
                            _,
                          ) {
                            userValue.clear();
                            passValue.clear();
                          });
                        } catch (e) {
                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(

                              content: Text(e.toString()),
                            ),
                          );
                        }
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                AppWidgets.verticalSpace(AppSpacing.medium),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: AppTextStyles.smallText,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterScareen(),
                          ),
                        );
                      },
                      style: AppButtons.text,
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(150, 50),
                    side: const BorderSide(color: AppColors.gold),
                  ),

                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/google.jpeg',
                        height: 35,
                        width: 35,
                      ),
                      SizedBox(width: 30),
                      const Text(
                        'Sign in with Google',
                        style: TextStyle(fontSize: 18, color: AppColors.gold),
                      ),
                    ],
                  ),
                ),

                AppWidgets.verticalSpace(50),

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
