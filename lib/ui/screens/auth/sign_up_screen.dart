import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/router.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';
import 'package:workout_tracker/utils/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final cPassController = TextEditingController();

  bool showPassword = false;
  bool showCPassword = false;

  String? cPassValidator(String? cPass) {
    if (cPassController.text.trim() != passController.text.trim()) {
      return "Passwords do not match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Create an account",
              style: AppTextStyles.heading,
              // textAlign: TextAlign.center,
            ),
            20.height,
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Name"),
              validator: (name) => Validators.nameValidator(name),
            ),
            20.height,
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: "Email"),
              validator: (email) => Validators.emailValidator(email),
            ),
            20.height,
            TextFormField(
              controller: passController,
              decoration: InputDecoration(
                hintText: "Password",
                suffixIcon: IconButton(
                  onPressed: () => setState(() => showPassword = !showPassword),
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
              validator: (pass) => Validators.passValidator(pass),
              obscureText: !showPassword,
            ),
            20.height,
            TextFormField(
              controller: cPassController,
              decoration: InputDecoration(
                hintText: "Confirm Password",
                suffixIcon: IconButton(
                  onPressed: () => setState(() => showCPassword = !showCPassword),
                  icon: Icon(
                    showCPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
              validator: cPassValidator,
              obscureText: !showCPassword,
            ),
            30.height,
            ElevatedButton(
              onPressed: () {
                context.goNamed(Routes.homeBase);
                return;
                if (formKey.currentState?.validate() == true) {}
              },
              child: Text("Sign Up"),
            ),
            30.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Already have an account?"),
                5.width,
                InkWell(
                  onTap: () {
                    context.goNamed(Routes.login);
                  },
                  child: Text(
                    "Login",
                    style: AppTextStyles.bodyBold.copyWith(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
