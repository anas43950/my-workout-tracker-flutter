import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/cubits/auth/login_cubit.dart';
import 'package:workout_tracker/router.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/components/loader.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';
import 'package:workout_tracker/utils/constants.dart';
import 'package:workout_tracker/utils/extensions.dart';
import 'package:workout_tracker/utils/helpers.dart';
import 'package:workout_tracker/utils/shared_preferences_utils.dart';
import 'package:workout_tracker/utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = false;
  GlobalKey<FormState> formKey = GlobalKey();
  final emailController = TextEditingController(text: const String.fromEnvironment('EMAIL', defaultValue: ''));
  final passController = TextEditingController(text: const String.fromEnvironment('PASS', defaultValue: ''));

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Form(
        key: formKey,
        child: BlocConsumer<LoginCubit, LoginState>(
          builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Welcome back!",
                style: AppTextStyles.heading.copyWith(fontSize: 30),
              ),
              5.height,
              Text(
                "Enter your email and password.",
                style: AppTextStyles.label.copyWith(color: grey),
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
                  if (formKey.currentState?.validate() == true) {
                    context.read<LoginCubit>().login(
                      emailController.text,
                      passController.text,
                    );
                  }
                },
                child: state is LoginInProgress ? CustomLoader() : Text("Login"),
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
                      style: AppTextStyles.bodyMedium.copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ],
          ),
          listener: (context, state) {
            if (state is LoginSuccess) {
              SharedPrefUtils.storeString(AppStrings.token, state.payload['token']);
              showSuccessSnackBar(context, "Logged in successfully");
              context.clearStackAndNavigate(Routes.homeBase);
            } else if (state is LoginFail) {
              showErrorSnackBar(context, state.message);
            }
          },
        ),
      ),
    );
  }
}
