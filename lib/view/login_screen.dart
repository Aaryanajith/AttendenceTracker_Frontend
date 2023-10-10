import 'package:attendencetracker/resources/color.dart';
import 'package:attendencetracker/resources/components/round_buttom.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:attendencetracker/view_model/authViewModel.dart';
import 'package:flutter/material.dart';
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
        child: Scaffold(
          body: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 400),
                    child: Image.asset(
                      'assets/amFOSS.png',
                      height: 300,
                      scale: 4,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration:
                            const BoxDecoration(color: ColorsClass.white),
                        width: MediaQuery.of(context).size.width,
                        height: 460,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        fontFamily: 'Roboto Condensed',
                                        fontSize: 40,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 0),
                                      child: TextFormField(
                                          decoration: const InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 160, 53, 60),
                                              )),
                                              contentPadding: EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                              ),
                                              floatingLabelStyle: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 160, 53, 60)),
                                              labelText: "Username",
                                              prefixIcon: Icon(Icons.mail),
                                              prefixIconColor:
                                                  ColorsClass.amber,
                                              hintStyle: TextStyle(
                                                  color: Colors.grey)),
                                          focusNode: usernameFocus,
                                          onFieldSubmitted: (value) {
                                            Utils.fieldFocusChange(context,
                                                usernameFocus, passwordFocus);
                                          },
                                          controller: _usernameTextController),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 0),
                                      child: TextFormField(
                                          focusNode: passwordFocus,
                                          obscureText: _obscureText,
                                          obscuringCharacter: '*',
                                          decoration: InputDecoration(
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 160, 53, 60),
                                            )),
                                            contentPadding:
                                                const EdgeInsets.only(
                                              left: 10.0,
                                              right: 10.0,
                                            ),
                                            floatingLabelStyle: const TextStyle(
                                                color: ColorsClass.amber),
                                            labelText: "Password",
                                            prefixIcon: const Icon(Icons.lock),
                                            prefixIconColor: ColorsClass.amber,
                                            // ignore: sort_child_properties_last
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _obscureText = !_obscureText;
                                                });
                                              },
                                              child: Icon(_obscureText
                                                  ? Icons.visibility_off
                                                  : Icons.visibility),
                                            ),
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                          controller: _passwordTextController),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: RoundButton(
                                      buttonName: 'Login',
                                      onPressed: () {
                                        if (_usernameTextController
                                            .text.isEmpty) {
                                          Utils.flushBarErrorMessage(
                                              'Please enter Username', context);
                                        } else if (_passwordTextController
                                            .text.isEmpty) {
                                          Utils.flushBarErrorMessage(
                                              'Please enter Password', context);
                                        } else {
                                          Map data = {
                                            "username": _usernameTextController
                                                .text
                                                .toString(),
                                            "password": _passwordTextController
                                                .text
                                                .toString()
                                          };
                                          authViewModel.login(data, context);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
