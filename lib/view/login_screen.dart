import 'package:attendencetracker/utlities/utils.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  final TextEditingController _usernameTextController = TextEditingController();

  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Utils.appBar(
        'amFOSS Attendence Tracker',
        automaticallyImplyLeading: false,
      ),
      extendBody: true,
      body: GestureDetector(
        onTap: () {},
        child: Scaffold(
          body: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned(
                  bottom: 0,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
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
                                      child: TextField(
                                          decoration: const InputDecoration(
                                              focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(255, 160, 53, 60),)),
                                              contentPadding: EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                              ),
                                              floatingLabelStyle:
                                              TextStyle(color: Color.fromARGB(255, 160, 53, 60)),
                                              labelText: "Username",
                                              prefixIcon: Icon(Icons.mail),
                                              prefixIconColor: Color.fromARGB(255, 208, 8, 70),
                                              hintStyle: TextStyle(
                                                  color: Colors.grey)),
                                          controller: _usernameTextController),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 0),
                                      child: TextField(
                                          obscureText: _obscureText,
                                          decoration: InputDecoration(
                                            focusedBorder: const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromARGB(255, 160, 53, 60),)),
                                            contentPadding:
                                                const EdgeInsets.only(
                                              left: 10.0,
                                              right: 10.0,
                                            ),
                                            floatingLabelStyle:
                                            const TextStyle(color: Color.fromARGB(255, 160, 53, 60)),
                                            labelText: "Password",
                                            prefixIcon: const Icon(Icons.lock),
                                            prefixIconColor: const Color.fromARGB(255, 208, 8, 70),
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
