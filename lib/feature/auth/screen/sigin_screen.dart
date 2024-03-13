import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/common/custom_textfield.dart';
import 'package:news_app/core/utils/shared_utility.dart';
import 'package:news_app/feature/auth/widgets/required_text.dart';
import 'package:news_app/theme/custom_theme.dart';

class SiginScreen extends ConsumerWidget {
  SiginScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _emailController.text = SharedUtility().getEmail();
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
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Again!',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: colors(context).color1),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Welcome back you've\nbeen missed",
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
                        Checkbox(
                          value: true,
                          onChanged: (value) {},
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
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
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: colors(context).color1,
                    ),
                    onPressed: () {},
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
