import 'package:amazon_clone_flutter_app/common/widgets/custom_textfield.dart';
import 'package:amazon_clone_flutter_app/common/widgets/custom_button.dart';
import 'package:amazon_clone_flutter_app/constants/global_variables.dart';
import 'package:amazon_clone_flutter_app/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

//enum for Radio value
enum Auth {
  signup,
  signin,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //group value for radio button
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    //for don't get the memory lick
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    //named navigator to switch the screens
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  value: Auth.signup,
                  activeColor: GlobalVariables.secondaryColor,
                  groupValue: _auth,
                  //(Auth? val) because we give Auth enum value in value parameter
                  onChanged: (Auth? val) {
                    setState(() {
                      //make sure that it never be the null value
                      _auth = val!;
                    });
                  },
                ),
              ),
              //if signUp Selected then show the SignUp Form
              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            controller: _nameController, hintText: 'Name'),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            controller: _emailController, hintText: 'Email'),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            controller: _passwordController,
                            hintText: 'Password'),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            text: 'Sign Up',
                            onTap: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUser();
                              }
                            })
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Sign-In.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  value: Auth.signin,
                  activeColor: GlobalVariables.secondaryColor,
                  groupValue: _auth,
                  //(Auth? val) because we give Auth enum value in value parameter
                  onChanged: (Auth? val) {
                    setState(() {
                      //make sure that it never be the null value
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            controller: _emailController, hintText: 'Email'),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            controller: _passwordController,
                            hintText: 'Password'),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            text: 'Sign In',
                            onTap: () {
                              if (_signInFormKey.currentState!.validate()) {
                                signInUser();
                              }
                            })
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
