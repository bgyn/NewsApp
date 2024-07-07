import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/common/custom_textfield.dart';
import 'package:news_app/core/utils/preference.dart';
import 'package:news_app/feature/auth/controller/auth_controller.dart';
import 'package:news_app/feature/auth/widgets/custom_button.dart';
import 'package:news_app/core/common/required_text.dart';
import 'package:news_app/theme/custom_theme.dart';

class SignupScreen extends ConsumerWidget {
  SignupScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void navigateToSignIn(BuildContext context) {
    GoRouter.of(context).pushReplacement('/signin');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: colors(context).color1),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Signup to get started",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 20,
                ),
                const RequireText(text: 'Email'),
                CustomTextField(
                  controller: _emailController,
                  isObscure: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                const RequireText(text: 'Password'),
                CustomTextField(
                  controller: _passwordController,
                  isObscure: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Consumer(builder: (context, ref, child) {
                          return Checkbox(
                            value: ref.watch(preferenceNotifierProvider),
                            onChanged: (value) {
                              ref
                                  .read(preferenceNotifierProvider.notifier)
                                  .setPreferenceRemeberMe(value!);
                            },
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          );
                        }),
                        Text(
                          "Remember me",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Forgot the password?"),
                    )
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: colors(context).color1,
                    ),
                    onPressed: () {
                      ref.read(preferenceNotifierProvider)
                          ? ref
                              .read(preferenceNotifierProvider.notifier)
                              .setEmail(_emailController.text)
                          : null;
                      ref
                          .read(authControllerProvider.notifier)
                          .signUpWithEmailPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                    },
                    child: Text(
                      "Login",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "or continue with",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  title: 'Google',
                  img: 'assets/images/google.png',
                  onClick: ref
                      .read(authControllerProvider.notifier)
                      .signInWithGoogle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => navigateToSignIn(context),
                      child: Text(
                        "Login",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colors(context).color1,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
