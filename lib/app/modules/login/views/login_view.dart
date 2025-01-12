import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_supabase/app/modules/widgets/input_field.dart';
import 'package:getx_supabase/app/routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 300,
                child: Image.asset('assets/images/logostar.png'),
              ),
              const SizedBox(height: 20),
              InputField(
                hintText: 'Enter Email',
                label: 'Email',
                controller: emailController,
                icon: Icons.email,
              ),
              const SizedBox(height: 15),
              Obx(() {
                return InputField(
                  hintText: 'Enter Password',
                  label: 'Passwords',
                  controller: passwordController,
                  obscureText: controller.togglePassword.value,
                  icon: controller.togglePassword.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  onIconPressed: controller.toggleShowPassword,
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.login(
                      emailController.text, passwordController.text);
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.SIGNUP);
                },
                child: const Text("Don't have an account? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
