import 'package:e_money/database/db_instance.dart';
import 'package:e_money/pages/main_page.dart';
import 'package:e_money/shared/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String errorMessage = '';
  var usernameColor = errorColor;
  var passworColor = errorColor;
  void _loadPage(
      String errorMessage, var usernameColor, var passwordColor) async {
    setState(() {
      this.errorMessage = errorMessage;
      this.usernameColor = usernameColor;
      this.passworColor = passworColor;
    });
  }

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 50),
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'images/logo.png',
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          "CASH APP",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: bold,
                            color: primary400,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextFormField(
                                controller: _usernameController,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Username tidak boleh kosong.";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: primary900,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: primary900,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 5,
                                  ),
                                  hintText: 'Username',
                                  hintStyle: TextStyle(color: primary600),
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                controller: _passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password tidak boleh kosong.";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: primary900),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: primary900),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  // ignore: prefer_const_constructors
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  suffixIcon: IconButton(
                                    onPressed: showHide,
                                    icon: Icon(_secureText
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    color: primary600,
                                    focusColor: primary900,
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: primary600,
                                  ),
                                ),
                                obscureText: _secureText,
                                enableSuggestions: false,
                                autocorrect: false,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary800,
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ).copyWith(
                              elevation: ButtonStyleButton.allOrNull(0.0)),
                          onPressed: () async {
                            await _login();
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Text(
                          //   'Sign In',
                          //   style: subHeadingSemiBold2White,
                          // ),
                        ),
                      ),
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

  Future<void> _login() async {
    var state = await DbInstance.login(
      _usernameController.text,
      _passwordController.text,
    );
    if (state.isNotEmpty) {
      _loadPage('', errorColor, errorColor);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Main(
            userId: state[0]['id'],
          ),
        ),
        (route) => false,
      );
    } else if (_usernameController.text == '' &&
        _passwordController.text == '') {
      _loadPage(
          'Username dan Password tidak boleh kosong!!', errorColor, errorColor);
    } else if (_usernameController.text == '') {
      _loadPage('Username tidak boleh kosong!!', errorColor, errorColor);
    } else if (_passwordController.text == '') {
      _loadPage('Password tidak boleh kosong!!', errorColor, errorColor);
    } else {
      _loadPage('Login gagal, Username atau Password tidak sesuai!', errorColor,
          errorColor);
    }
  }
}
