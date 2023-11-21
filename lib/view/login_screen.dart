import 'package:attendencetracker/resources/color.dart';
import 'package:attendencetracker/resources/components/round_button.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:attendencetracker/view_model/authViewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  FocusNode usernameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();

    _usernameTextController.dispose();
    _passwordTextController.dispose();

    usernameFocus.dispose();
    passwordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Utils.appBar(
        'amFOSS Attendence Tracker',
        automaticallyImplyLeading: false,
      ),
      extendBody: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: ColorsClass.lightBlack,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      height: 170,
                    ),
                    Image.asset(
                      'assets/amFOSS.png',
                      scale: 3,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 80,
                    ),
                    Text(
                      'LOGIN',
                      style: GoogleFonts.oxygen(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: ColorsClass.white),
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorsClass.amber,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10),
                            floatingLabelStyle:
                                TextStyle(color: ColorsClass.amber),
                            labelText: 'Username',
                            labelStyle: TextStyle(color: ColorsClass.white),
                            prefixIcon: Icon(Icons.mail),
                            prefixIconColor: ColorsClass.amber,
                            hintStyle: TextStyle(color: ColorsClass.white)),
                        style: const TextStyle(color: ColorsClass.white),
                        focusNode: usernameFocus,
                        onFieldSubmitted: (value) {
                          Utils.fieldFocusChange(
                              context, usernameFocus, passwordFocus);
                        },
                        controller: _usernameTextController,
                      ),
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: TextFormField(
                        focusNode: passwordFocus,
                        obscureText: _obscureText,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorsClass.amber,
                            ),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                          ),
                          floatingLabelStyle:
                              const TextStyle(color: ColorsClass.amber),
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: ColorsClass.white),
                          prefixIcon: const Icon(Icons.lock),
                          prefixIconColor: ColorsClass.amber,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: ColorsClass.amber,
                            ),
                          ),
                          hintStyle: const TextStyle(color: ColorsClass.white),
                        ),
                        style: const TextStyle(color: ColorsClass.white),
                        controller: _passwordTextController,
                      ),
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 140),
                      child: RoundButton(
                          buttonName: 'Login',
                          onPressed: () {
                            if (_usernameTextController.text.isEmpty) {
                              Utils.flushBarErrorMessage(
                                  'Please enter Username', context);
                            } else if (_passwordTextController.text.isEmpty) {
                              Utils.flushBarErrorMessage(
                                  'Please enter Password', context);
                            } else {
                              Map data = {
                                "username":
                                    _usernameTextController.text.toString(),
                                "password":
                                    _passwordTextController.text.toString()
                              };
                              authViewModel.login(data, context);
                            }
                          }),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
