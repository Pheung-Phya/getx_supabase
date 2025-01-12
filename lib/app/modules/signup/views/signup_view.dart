import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_supabase/app/modules/widgets/input_field.dart';

import '../../../routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  SignupView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
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
                hintText: 'Enter Name',
                label: 'Name',
                controller: emailController,
                icon: Icons.person,
              ),
              const SizedBox(height: 15),
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
                onPressed: () {},
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
