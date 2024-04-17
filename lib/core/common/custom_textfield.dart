import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTextField extends ConsumerWidget {
  final TextEditingController _controller;
  final bool? _isObscure;
  final obscureProvider = StateProvider<bool>((ref) => true);
  CustomTextField(
      {super.key, required TextEditingController controller, bool? isObscure})
      : _controller = controller,
        _isObscure = isObscure ?? false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hidePassword = ref.watch(obscureProvider);
    return TextField(
      style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 14),
      controller: _controller,
      obscureText: _isObscure! ? hidePassword : false,
      decoration: InputDecoration(
        suffixIcon: _isObscure
            ? IconButton(
                onPressed: () {
                  ref.read(obscureProvider.notifier).update((state) => !state);
                },
                icon: hidePassword
                    ? const Icon(Icons.remove_red_eye)
                    : const Icon(Icons.remove_red_eye_outlined),
              )
            : null,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
