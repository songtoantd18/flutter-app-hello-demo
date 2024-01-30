import 'package:flutter/material.dart';

import '../registerPage/registerPage.dart';

import '../forgetPassword/forgetPassword.dart';
import '../../constants/data.dart';

import '../../function/loginFunction.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../locationPage/locationPage.dart';
import '../notificationPage/notificationPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _usernameError = false;
  bool _passwordError = false;
  bool _passwordVisible = false;
  final apiUrlValue = dataValue.apiUrl;

  Widget buildLoginForm() {
    return Column(
      children: [
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            labelText: 'Username',
            errorText: _usernameError ? 'Invalid Username' : null,
            prefixIcon: Icon(Icons.person),
          ),
          onChanged: (value) {
            setState(() {
              // Regex cho tên đăng nhập
              _usernameError = RegExp(dataValue.regex).hasMatch(value);
            });
          },
        ),
        SizedBox(height: 16.0),
        TextField(
          controller: _passwordController,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.password_outlined),
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
            errorText: _passwordError ? 'Invalid Password' : null,
          ),
          onChanged: (value) {
            setState(() {
              _passwordError = RegExp(dataValue.regex).hasMatch(value);
            });
          },
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ForgotPasswordPage(),
                ),
              );
            },
            child: Text(
              'Quên mật khẩu',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: 15.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                dataValue.logo,
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              SizedBox(height: 16.0),
              buildLoginForm(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                  onPrimary: Colors.white,
                  minimumSize: Size(80, 40),
                ),
                onPressed: () async {
                  Future<void> _delayedFunction(Function function) async {
                    await Future.delayed(Duration(seconds: 2));
                    function();
                  }

                  await _delayedFunction(() {
                    EasyLoading.show(status: 'loading...');
                  });

                  await _delayedFunction(() {
                    EasyLoading.dismiss();
                  });
                  handleLogin(context, _usernameController.text,
                      _passwordController.text, apiUrlValue, () {
                    setState(() {
                      _usernameError = true;
                      _passwordError = true;
                    });

                    // Ẩn chỉ báo đang chờ sau khi xử lý xong
                  });
                },
                child: Text('Đăng nhập'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  onPrimary: Colors.white,
                  minimumSize: Size(80, 40),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                child: Text('Đăng ký'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  onPrimary: Colors.white,
                  minimumSize: Size(80, 40),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationPage(),
                    ),
                  );
                },
                child: Text('location'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  onPrimary: Colors.white,
                  minimumSize: Size(80, 40),
                ),
                onPressed: () {},
                child: Text('notificat 2 2 2 2 2oiuyiiluuyi 2 2ion'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
