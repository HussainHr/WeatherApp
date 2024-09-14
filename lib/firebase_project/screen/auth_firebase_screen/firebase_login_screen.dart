import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/config/provider/firebase_auth_provider.dart';
import 'package:weather_app/firebase_project/screen/auth_firebase_screen/firebase_sign_up_screen.dart';
import 'package:weather_app/firebase_project/screen/home/firebase_home_screen.dart';
import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_or_widget.dart';
import '../../../common_widget/custom_screen.dart';
import '../../../common_widget/custom_text_form_field.dart';

class FirebaseLoginScreen extends ConsumerStatefulWidget {
  const FirebaseLoginScreen({super.key});

  @override
  ConsumerState createState() => _FirebaseLoginScreenState();
}

class _FirebaseLoginScreenState extends ConsumerState<FirebaseLoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  late String errorText = '';

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  void login() async {
    if (formKey.currentState!.validate()) {
      try {
        final authService = ref.read(firebaseAuthServiceProvider);
        User? user = await authService.login(
          _emailTextController.text,
          _passwordTextController.text,
        );
        if (user != null) {
          ref.read(authStateProvider.notifier).state = user;
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
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
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
          title: 'Login',
          customWidget: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      topHeight: 20,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTextController,
                      textInputAction: TextInputAction.next,
                      hintText: 'Email address',
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
                        child: Text(
                          'Minimum six digit',
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
                    "Login",
                    // style: appStyle,
                  ),
                ),
                onPressed: () {
                  login();
                  _emailTextController.clear();
                  _passwordTextController.clear();
                },
              ),
              if (errorText.isNotEmpty) Text('Exception: $errorText'),
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
                        "sing in with google",
                        // style: duration1Style,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  text: "Don't have an account ",
                  // style: skipStyle,
                  children: [
                    TextSpan(
                      text: 'sign in',
                      // style: title6Style,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const FirebaseSignUpScreen(),
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
