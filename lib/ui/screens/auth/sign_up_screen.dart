import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:workout_tracker/data/cubits/auth/register_cubit.dart';
import 'package:workout_tracker/router.dart';
import 'package:workout_tracker/ui/components/custom_scaffold.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';
import 'package:workout_tracker/utils/constants.dart';
import 'package:workout_tracker/utils/extensions.dart';
import 'package:workout_tracker/utils/helpers.dart';
import 'package:workout_tracker/utils/shared_preferences_utils.dart';
import 'package:workout_tracker/utils/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  final nameController = TextEditingController(text: const String.fromEnvironment('NAME', defaultValue: ''));
  final emailController = TextEditingController(text: const String.fromEnvironment('EMAIL', defaultValue: ''));
  final passController = TextEditingController(text: const String.fromEnvironment('PASS', defaultValue: ''));
  final cPassController = TextEditingController(text: const String.fromEnvironment('PASS', defaultValue: ''));

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
        child: BlocConsumer<RegisterCubit, RegisterState>(
          builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "No account? No worries!",
                style: AppTextStyles.heading.copyWith(fontSize: 30),
                // textAlign: TextAlign.center,
              ),
              5.height,
              Text(
                "Enter your details, and let's get started.",
                style: AppTextStyles.label.copyWith(color: grey),
              ),
              20.height,
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: "Name"),
                validator: (name) => Validators.emptyValidator(name, "Enter your name"),
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
                validator: (pass) => Validators.lengthValidator(
                  pass,
                  Constants.MIN_PASS_LENGTH,
                  "Password should be at least ${Constants.MIN_PASS_LENGTH} characters",
                ),
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
                  if (formKey.currentState?.validate() == true) {
                    context.read<RegisterCubit>().register(
                      nameController.text,
                      emailController.text,
                      passController.text,
                    );
                  }
                },
                child: state is RegisterInProgress ? CupertinoActivityIndicator(color: Colors.white) : Text("Sign Up"),
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
                      style: AppTextStyles.bodyMedium.copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ],
          ),
          listener: (context, state) {
            if (state is RegisterSuccess) {
              SharedPrefUtils.storeString(AppStrings.token, state.token);
              SharedPrefUtils.storeString(AppStrings.userFullName, state.user.name);
              showSuccessSnackBar(context, "Account created successfully");
              context.clearStackAndNavigate(Routes.homeBase);
            } else if (state is RegisterFail) {
              showErrorSnackBar(context, state.message);
            }
          },
        ),
      ),
    );
  }
}
