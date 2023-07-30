import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/bloc/login/login_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/bloc/register/register_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/data/datasources/auth_local_datasource.dart';
import 'package:flutter_fic6_ecommerce_tv/data/models/login_request_model.dart';
import 'package:flutter_fic6_ecommerce_tv/data/models/register_request_model.dart';

import '../../common/custom_button.dart';
import '../../common/custom_textfield.dart';
import '../../common/global_variables.dart';
import '../home/home_page.dart';

enum Auth {
  signin,
  signup,
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                tileColor: GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.greyBackgroundCOlor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          hintText: 'Name',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(height: 10),
                        BlocConsumer<RegisterBloc, RegisterState>(
                          listener: (context, state) {
                            state.maybeWhen(
                              orElse: () {},
                              error: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Register Error'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                              loaded: (model) async {
                                await AuthLocalDatasource().saveAuthData(model);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const HomePage();
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return CustomButton(
                                  text: 'Sign Up',
                                  onTap: () {
                                    if (_signUpFormKey.currentState!
                                        .validate()) {
                                      final requestModel = RegisterRequestModel(
                                        name: _nameController.text,
                                        password: _passwordController.text,
                                        email: _emailController.text,
                                        username: _nameController.text,
                                      );

                                      context.read<RegisterBloc>().add(
                                          RegisterEvent.register(requestModel));
                                    }
                                  },
                                );
                              },
                              loading: () => const Center(
                                  child: CircularProgressIndicator()),
                            );
                          },
                        )
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
                  activeColor: GlobalVariables.greyBackgroundCOlor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
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
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(height: 10),
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) async {
                            if (state is LoginLoaded) {
                              await AuthLocalDatasource()
                                  .saveAuthData(state.model);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const HomePage();
                                  },
                                ),
                              );
                            }
                            if (state is LoginError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.red,
                                    content:
                                        Text('Login gagal, check data anda')),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is LoginLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return CustomButton(
                              text: 'Sign In',
                              onTap: () {
                                if (_signInFormKey.currentState!.validate()) {
                                  final model = LoginRequestModel(
                                    identifier: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                  context
                                      .read<LoginBloc>()
                                      .add(DoLoginEvent(model: model));
                                }
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffEE4D2D)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const HomePage();
                      }));
                    },
                    child: const Text(
                      'Continue as a Guest',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
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
