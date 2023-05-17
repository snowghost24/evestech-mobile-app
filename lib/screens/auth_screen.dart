// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/device_info.dart';
import '../providers/auth.dart';
import '../models/http_exception.dart';
import '../services/apple_login.dart';
import '../services/google_login.dart';
import '../services/helpers.dart';
import '../widgits/terms_policy.dart';

// ignore: constant_identifier_names
enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      //  backgroundColor: const Color.fromRGBO(30, 52, 86, 10),
      backgroundColor: Theme.of(context).primaryColor,
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          height: deviceSize.height,
          width: deviceSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Flexible(
              //   child: Container(
              //     margin: const EdgeInsets.only(bottom: 20.0),
              //     padding: const EdgeInsets.symmetric(
              //         vertical: 8.0, horizontal: 94.0),
              //     child: Image.asset('assets/images/company_logo_icon.png'),
              //   ),
              // ),
              Flexible(
                flex: deviceSize.width > 600 ? 2 : 1,
                child: const AuthCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('An Error Ocurred'),
            content: Text(message),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("Okey"))
            ],
          );
        });
  }

  // Future<void> _submit() async {

  //   if (!_formKey.currentState!.validate()) {
  //     // Invalid!
  //     return;
  //   }
  //   _formKey.currentState!.save();
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   try {
  //      var hash = Provider.of<DeviceInfo>(context, listen: false).hash;
  //     if (_authMode == AuthMode.Login) {

  //      print("hash");
  //      print(hash);
  //       await Provider.of<Auth>(context, listen: false).login(
  //           _authData['email'] as String, _authData['password'] as String, hash as String);
  //     } else {
  //       await Provider.of<Auth>(context, listen: false).signup(
  //           _authData['email'] as String, _authData['password'] as String, hash as String);
  //     }
  //   } on HttpException catch (error) {
  //     var errorMessage = 'Authentication failed';
  //     if (error.toString().contains('EMAIL_EXISTS')) {
  //       errorMessage = 'This email already exists';
  //     } else if (error.toString().contains('INVALID_EMAIL')) {
  //     } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
  //       errorMessage = 'Could not find user with this email ';
  //     } else if (error.toString().contains('INVALID_PASSWORD')) {
  //       errorMessage = 'Invalid password ';
  //     }
  //     _showErrorDialog(errorMessage);
  //   } catch (e) {
  //     const errorMessage = 'Could not authenticate you. Please try again later';
  //     _showErrorDialog(errorMessage);
  //   }

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      print("something aint valid");
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      print("submittiong requiest");
      var hash = Provider.of<DeviceInfo>(context, listen: false).hash;
      await Provider.of<Auth>(context, listen: false).emaiPasswordAuthenticate(
          _authData['email'] as String,
          _authData['password'] as String,
          hash as String);
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (e) {
      const errorMessage = 'Could not authenticate you. Please try again later';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        // height: _authMode == AuthMode.Signup ? 460 : 390,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 420 : 360),
        width: deviceSize.width * .85,
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  // height: 200,
                  margin: const EdgeInsets.only(bottom: 30, top: 22),
                  child: Image.asset('assets/images/company_logo_icon.png'),
                ),
                const GoogleLogin(),
                const SizedBox(height: 6),
                const AppleLogin(),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: const Divider()),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match!';
                              }
                            }
                          : null,
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                  ),
                Consumer<Helpers>(builder: (ctx, helpers, _) {
                  return TextButton(
                    onPressed: () {
                      helpers.launchURL(Constants.forgotPassword);
                    },
                    //  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: const Text('Forgot Password'),
                  );
                }),
                const TermsPolicy(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
