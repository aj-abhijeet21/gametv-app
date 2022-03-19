import 'package:flutter/material.dart';
import 'package:gametv_app/screens/home.dart';
import 'package:gametv_app/screens/newHome.dart';
import 'package:gametv_app/services/api_service.dart';
import 'package:gametv_app/services/app_state.dart';
import 'package:gametv_app/services/constants.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('images/logo.jpg'),
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: userController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.grey,
                  filled: true,
                  hintText: 'Enter user name',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                  errorStyle: const TextStyle(color: Colors.orange),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username cannot be empty';
                  }
                  if (value.length < 3 || value.length > 11) {
                    return 'Username length must be in the range of 3 to 11';
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.grey,
                  filled: true,
                  hintText: 'Enter password',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                  errorStyle: const TextStyle(color: Colors.orange),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be empty';
                  }
                  if (value.length < 3 || value.length > 11) {
                    return 'Password length must be in the range of 3 to 11';
                  }
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Login Failed',
                                style: TextStyle(color: Colors.orange),
                              ),
                            ),
                          );
                          return;
                        }

                        AuthStatus authStatus = await ApiService().logIn(
                          username: userController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        if (authStatus != AuthStatus.authenticated) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Login Failed',
                                style: TextStyle(color: Colors.orange),
                              ),
                            ),
                          );
                        }

                        if (authStatus == AuthStatus.authenticated) {
                          // await ApiService().getTournaments();
                          Provider.of<AppStateProvider>(context, listen: false)
                              .setUser(userController.text.trim());
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                          );
                        } else {
                          userController.clear();
                          passwordController.clear();
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
