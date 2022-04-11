import 'package:flutter/material.dart';
import 'package:my_todo_app/src/screens/todos/todo_screen.dart';
import 'package:my_todo_app/src/controllers/auth_controller.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);
  final AuthController _authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _authController,
        builder: (context, Widget? w) {
          if (_authController.currentUser == null) {
            return AuthScreen(_authController);
          } else {
            return TodoScreen(_authController);
          }
        });
  }
}

class AuthScreen extends StatefulWidget {
  final AuthController auth;
  const AuthScreen(
    this.auth, {
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unCon = TextEditingController(),
      _passCon = TextEditingController();
  String prompts = '';
  AuthController get _auth => widget.auth;

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff4338CA);
    const accentColor = Color(0xffffffff);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  onChanged: () {
                    _formKey.currentState?.validate();
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                            child: const Text('My',
                                style: TextStyle(
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 70.0, 0.0, 0.0),
                            child: const Text('Todoos',
                                style: TextStyle(
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.only(
                              top: 25.0, left: 20.0, right: 20.0),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration:
                                    const InputDecoration(hintText: 'Username'),
                                controller: _unCon,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Password',
                                ),
                                controller: _passCon,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 5.0),
                              Container(
                                //alignment: const Alignment(1.0, 0.0),
                                padding: const EdgeInsets.only(
                                    top: 15.0, left: 20.0),
                                child: Text(
                                  prompts,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  // gradient: const LinearGradient(colors: [primaryColor, secondaryColor]),
                                  color:
                                      _formKey.currentState?.validate() == true
                                          ? primaryColor
                                          : Colors.grey,
                                  //gradient: (_formKey.currentState?.validate() ??  false) ?? LinearGradient(colors: [primaryColor, secondaryColor]) : Colors.grey,
                                ),
                                child: ElevatedButton(
                                    onPressed:
                                        (_formKey.currentState?.validate() ??
                                                false)
                                            ? () {
                                                bool result = _auth.login(
                                                    _unCon.text, _passCon.text);
                                                if (!result) {
                                                  setState(() {
                                                    prompts =
                                                        'Error logging in, username or password may be incorrect or the user has not been registered yet.';
                                                  });
                                                }
                                              }
                                            : null,
                                    child: const Text(
                                      'Log In',
                                      style: TextStyle(
                                          color: accentColor, fontSize: 16),
                                    ),
                                    style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        alignment: Alignment.center,
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.only(
                                                right: 110,
                                                left: 110,
                                                top: 15,
                                                bottom: 15)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ))),
                              ),
                              const SizedBox(height: 10.0),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      _formKey.currentState?.validate() == true
                                          ? primaryColor
                                          : Colors.grey,
                                ),
                                child: ElevatedButton(
                                    onPressed:
                                        (_formKey.currentState?.validate() ??
                                                false)
                                            ? () {
                                                String result = _auth.register(
                                                    _unCon.text, _passCon.text);
                                                setState(() {
                                                  prompts = result;
                                                });
                                              }
                                            : null,
                                    child: const Text(
                                      'Register',
                                      style: TextStyle(
                                          color: accentColor, fontSize: 16),
                                    ),
                                    style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        alignment: Alignment.center,
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.only(
                                                right: 100,
                                                left: 100,
                                                top: 15,
                                                bottom: 15)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ))),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
