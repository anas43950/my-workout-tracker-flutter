import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/router.dart';
import 'package:workout_tracker/ui/screens/base_scaffold.dart';
import 'package:workout_tracker/ui/theme/text_styles.dart';
import 'package:workout_tracker/utils/extensions.dart';
import 'package:workout_tracker/utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = false;
  GlobalKey<FormState> formKey = GlobalKey();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: Color(0xfff1f1f1),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Login to continue",
              style: TextStyles.heading,
            ),
            20.height,
            TextFormField(
              decoration: InputDecoration(hintText: "Email"),
              controller: emailController,
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
            30.height,
            ElevatedButton(
              onPressed: () {
                context.goNamed(Routes.home);
                return;
                if (formKey.currentState?.validate() == true) {}
              },
              child: Text("Login"),
            ),
            30.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Don't have an account?"),
                5.width,
                InkWell(
                  onTap: () {
                    context.goNamed(Routes.signup);
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyles.subHeading.copyWith(decoration: TextDecoration.underline),
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
