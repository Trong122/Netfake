import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netfake/features/auth/presentation/provider/auth_provider.dart';
import 'package:go_router/go_router.dart';
import '/core/routing/app_routes.dart';

class SignupPages extends ConsumerStatefulWidget {
  const SignupPages({super.key});

  @override
  ConsumerState<SignupPages> createState() => _SigngunScreenState();
}

class _SigngunScreenState extends ConsumerState<SignupPages> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _displayController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _displayController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    final authController = ref.read(authControllerProvider.notifier);
    try {
      await authController.signUp(
        _emailController.text,
        _passwordController.text,
        _displayController.text,
      );
      if (mounted) {
        context.go(AppRoutes.login);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Đăng ký thất bại: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // keyboard hiện không rebuild toàn bộ
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            SvgPicture.asset('assets/Logo.svg', width: 40, height: 40),
            const SizedBox(width: 8),
            const Text(
              "NetFake",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          // tránh overflow khi keyboard bật
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              DisplayNameField(controller: _displayController,),
              const SizedBox(height: 20),
              EmailField(controller: _emailController),
              const SizedBox(height: 20),
              PasswordField(controller: _passwordController),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleLogin,
                  child: const Text("Đăng kí"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Widget riêng cho Email ---
class EmailField extends StatelessWidget {
  final TextEditingController controller;
  const EmailField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person_outline),
        hintText: "Tài khoản",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

// --- Widget riêng cho Display Name ---
class DisplayNameField extends StatelessWidget {
  final TextEditingController controller;
  const DisplayNameField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        hintText: "Tên hiển thị",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

// --- Widget riêng cho Password ---
class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  const PasswordField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_outline),
        hintText: "Mật khẩu",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
