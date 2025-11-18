// import 'package:flutter/material.dart';

// import 'package:movin/screens/main_home_screen.dart';
// import 'package:movin/screens/register_scareen.dart';
// import 'package:movin/widgets/constans.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool obscureText = true;
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController userValue = TextEditingController();
//   TextEditingController passvalue = TextEditingController();
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
//           child: Form(
//             key: _formKey,
//             child: ListView(
//               children: [
//                 Image.asset(logoKey, height: 200, width: 200),
//                 Center(
//                   child: const Text(
//                     'Welcome to Movin',
//                     style: TextStyle(
//                       fontSize: 27,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),

//                 Center(
//                   child: const FittedBox(
//                     fit: BoxFit.scaleDown,
//                     child: Text(
//                       'Your journey to the perfect property starts here',
//                       style: TextStyle(fontSize: 24, color: Colors.grey),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 24),
//                 Text(
//                   'Email',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 TextFormField(
//                   cursorColor: goldColor,
//                   controller: userValue,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'email is required';
//                     } else if (!value.contains('@')) {
//                       return 'enter valid email';
//                     }
//                     return null;
//                   },
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(
//                       Icons.email_outlined,
//                       color: Colors.grey,
//                     ),
//                     hintText: 'Enter your email',
//                     filled: true,
//                     fillColor: Colors.grey.shade200,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: goldColor),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   'Password',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 TextFormField(
//                   cursorColor: goldColor,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'password is required';
//                     }
//                     return null;
//                   },
//                   controller: passvalue,
//                   obscureText: obscureText,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(
//                       Icons.lock_outline,
//                       color: Colors.grey,
//                     ),
//                     suffixIcon: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           obscureText = !obscureText;
//                         });
//                       },
//                       icon: Icon(
//                         !obscureText ? Icons.visibility : Icons.visibility_off,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     hintText: 'Password',
//                     filled: true,
//                     fillColor: Colors.grey.shade200,
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: goldColor),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         // Navigate to forgot password screen
//                       },
//                       child: const Text(
//                         'Forgot Password?',
//                         style: TextStyle(color: goldColor),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       Navigator.of(context)
//                           .push(
//                             MaterialPageRoute(
//                               builder: (context) {
//                                 return MainHomeScreen();
//                               },
//                             ),
//                           )
//                           .then((value) {
//                             userValue.clear();
//                             passvalue.clear();
//                           });
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: navyPrimary,
//                     minimumSize: const Size(150, 50),
//                   ),
//                   child: const Text(
//                     'Login',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Don't have an account?",
//                         style: TextStyle(color: Colors.grey, fontSize: 18),
//                       ),
//                       TextButton(
//                         style: TextButton.styleFrom(
//                                 padding: EdgeInsets.zero,
//                                 minimumSize: Size(
//                                   0,
//                                   0,
//                                 ),
//                                 tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                               ),
//                         onPressed: () {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) {
//                                 return RegisterScareen();
//                               },
//                             ),
//                           );
//                         },
//                         child: const Text(
//                           "Sign up",
//                           style: TextStyle(color: goldColor),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: ()  {

//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     minimumSize: const Size(150, 50),
//                     side: const BorderSide(color: goldColor)
//                   ),

//                   child: Row(

//                     children: [
//                       Image.asset('assets/images/google _icon.png',height: 35,width:35,),
//                       SizedBox(
//                         width: 30,
//                       ),
//                       const Text(
//                         'Sign in with Google',
//                         style: TextStyle(fontSize: 18, color:goldColor),

//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 50),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       FittedBox(
//                         fit: BoxFit.scaleDown,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const Text(
//                               'By continuing in, you agree to our ',
//                               style: TextStyle(color: Colors.grey, height: 1.0),
//                             ),
//                             TextButton(
//                               style: TextButton.styleFrom(
//                                 padding: EdgeInsets.zero,
//                                 minimumSize: Size(
//                                   0,
//                                   0,
//                                 ),
//                                 tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                               ),
//                               onPressed: () {
//                                 // Navigate to Terms of Service
//                               },
//                               child: const Text(
//                                 'Terms of Service',
//                                 style: TextStyle(color: goldColor, height: 1.0),
//                               ),
//                             ),
//                           ],
//                         ),

//                       ),
//                       SizedBox(height: 10,),
//                       FittedBox(
//                         fit: BoxFit.scaleDown,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               'and ',
//                               style: TextStyle(color: Colors.grey, height: 1.0),
//                             ),
//                             TextButton(
//                               style: TextButton.styleFrom(
//                                 padding: EdgeInsets.zero,
//                                 minimumSize: Size(0, 0),
//                                 tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                               ),
//                               onPressed: () {
//                                 // Navigate to Privacy Policy
//                               },
//                               child: const Text(
//                                 'Privacy Policy',
//                                 style: TextStyle(color: goldColor, height: 1.0),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/login/screens/register_screen.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';

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
                AppWidgets.logo(LogoKeys.logoKey, size: 200),
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
                      await SharedHelper.setLoggedIn(true);
                      if (!context.mounted) return;
                      Navigator.pushReplacementNamed(context, '/role').then((
                        _,
                      ) {
                        userValue.clear();
                        passValue.clear();
                      });
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
