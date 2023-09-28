import 'package:e_money/database/db_instance.dart';
import 'package:e_money/pages/login_page.dart';
import 'package:e_money/shared/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  final int? userId;
  const Setting({Key? key, this.userId}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  String errorMessage = '';
  var oldPasswordColor = errorColor;
  var newPasswordColor = errorColor;

  void _loadPage(
      String errorMessage, var oldPasswordColor, var newPasswordColor) async {
    setState(() {
      this.errorMessage = errorMessage;
      this.oldPasswordColor = oldPasswordColor;
      this.newPasswordColor = newPasswordColor;
    });
  }

  @override
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary300,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: primary300,
              height: MediaQuery.of(context).size.height * .14,
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 56),
                    child: Center(
                      child: Text(
                        'Setting',
                        style: TextStyle(
                          fontSize: 20,
                          color: black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, top: 56),
                      child: IconButton(
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 56, 14, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        "Change Password",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          controller: _oldPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: primary300),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: primary300),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Old Password',
                            hintStyle: TextStyle(fontSize: 16, color: black),
                          ),
                          obscureText: _secureText,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: TextStyle(),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          controller: _newPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: primary300),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: primary300),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'New Password',
                            hintStyle: TextStyle(fontSize: 16, color: black),
                          ),
                          obscureText: _secureText,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: TextStyle(),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await _changePassword();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: primary900,
                        ),
                        margin: const EdgeInsets.only(top: 16),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 28,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
                      child: Center(
                        child: Text(
                          errorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: errorColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                          (route) => false,
                        )
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: errorColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 28,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'images/nabila.jpg',
                            width: 147,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: Text(
                                'About this App..',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Aplikasi ini dibuat oleh:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.0),
                              child: Text('Nama: Nabila Kamilia'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.0),
                              child: Text('NIM: 1941720158'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.0),
                              child: Text('Tanggal: 27 September 2023'),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changePassword() async {
    var state = await DbInstance.changePassword(
      int.parse(widget.userId.toString()),
      _oldPasswordController.text,
      _newPasswordController.text,
    );

    if (state) {
      _loadPage('', successColor, successColor);
    } else if (_oldPasswordController.text == '' &&
        _newPasswordController.text == '') {
      _loadPage('Semua field harus di isi!', errorColor, errorColor);
    } else if (_oldPasswordController.text == '') {
      _loadPage('Password lama harus di isi!', errorColor, successColor);
    } else if (_newPasswordController.text == '') {
      _loadPage('Password baru harus di isi!', successColor, errorColor);
    } else {
      _loadPage('Password lama salah', errorColor, errorColor);
    }
  }
}
