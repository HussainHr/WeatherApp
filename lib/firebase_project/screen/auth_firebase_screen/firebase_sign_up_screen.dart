import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/config/provider/firebase_auth_provider.dart';
import 'package:weather_app/firebase_project/screen/auth_firebase_screen/firebase_login_screen.dart';

import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_or_widget.dart';
import '../../../common_widget/custom_screen.dart';
import '../../../common_widget/custom_text_form_field.dart';
import '../home/firebase_home_screen.dart';

class FirebaseSignUpScreen extends ConsumerStatefulWidget {
  const FirebaseSignUpScreen({super.key});

  @override
  ConsumerState createState() => _FirebaseSignUpScreenState();
}

class _FirebaseSignUpScreenState extends ConsumerState<FirebaseSignUpScreen> {
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  late FocusNode nameFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late String errorText = '';

  void signUp() async {
    if (formKey.currentState!.validate()) {
      try {
        final authService = ref.read(firebaseAuthServiceProvider);
        User? user = await authService.signUp(_nameTextController.text,
            _emailTextController.text, _passwordTextController.text);
        if (user != null) {
          ref.read(authStateProvider.notifier).state != user;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => FirebaseHomeScreen(
              ),
            ),
          );
        }
      } catch (e) {
        setState(() {
          errorText = e.toString();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    nameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: CustomScreen(
          containerHeight: 690,
          height: 20,
          title: 'Sign Up',
          customWidget: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      topHeight: 48,
                      keyboardType: TextInputType.text,
                      controller: _nameTextController,
                      textInputAction: TextInputAction.next,
                      hintText: 'Enter Full Name',
                      labelText: 'Full name',
                      focusNode: nameFocusNode,
                      nextFocusNode: emailFocusNode,
                      onFieldSubmitted: () {
                        emailFocusNode.requestFocus();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      topHeight: 20,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTextController,
                      textInputAction: TextInputAction.next,
                      hintText: 'Email',
                      labelText: 'Email',
                      focusNode: emailFocusNode,
                      nextFocusNode: passwordFocusNode,
                      onFieldSubmitted: () {
                        passwordFocusNode.requestFocus();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'email cannot be empty';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      topHeight: 20,
                      controller: _passwordTextController,
                      textInputAction: TextInputAction.done,
                      hintText: 'Enter password',
                      labelText: 'password',
                      obscureText: !isPasswordVisible,
                      focusNode: passwordFocusNode,
                      onFieldSubmitted: () {},
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        child: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 1),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 14),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('minimum six digit'
                            // style: durationStyle,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              CustomButton(
                color: Colors.deepOrange,
                widget: const Center(
                  child: Text(
                    "Create Account",
                    // style: appStyle,
                  ),
                ),
                onPressed: () {
                  signUp();
                  _nameTextController.clear();
                  _emailTextController.clear();
                  _passwordTextController.clear();
                },
              ),
              if (errorText.isNotEmpty) Text("Error is: $errorText"),
              const SizedBox(height: 40),
              const CustomOrWidget(),
              const SizedBox(height: 40),
              CustomButton(
                onPressed: () {},
                color: Colors.white,
                widget: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SvgPicture.asset('assets/images/Google.svg'),
                    SizedBox(width: 20),
                    Center(
                      child: Text(
                        "sing up with google",
                        // style: duration1Style,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  text: "Have an account ",
                  // style: skipStyle,
                  children: [
                    TextSpan(
                      text: 'Login',
                      // style: title6Style,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FirebaseLoginScreen(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
