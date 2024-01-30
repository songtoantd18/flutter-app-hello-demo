import 'package:flutter/material.dart';
import 'dart:convert';

import '../../constants/data.dart';
import '../../function/actionApi.dart';
import '../loginPage/loginPage.dart';

// import '../../constants/data.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _passwordVisible = false;
  String errorMessage = '';
  bool _usernameError = false;
  bool _passwordError = false;

  Future<void> registerUser(String username, String password) async {
    final apiUrl = dataValue.apiUrl;

    try {
      final response = await getApi(apiUrl);
      final List<dynamic> users = jsonDecode(response.body);

      if (users.any((user) => user['userName'] == username)) {
        showError('Tên đăng nhập đã tồn tại. Vui lòng chọn tên khác.');
        return;
      }

      if (_passwordController.text != _confirmPasswordController.text) {
        showError('Mật khẩu không khớp. Vui lòng nhập lại.');
        return;
      }

      final registrationResponse = await postApi(apiUrl, {
        "userName": username,
        "password": password,
      });

      if (registrationResponse.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đăng ký thành công.'),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        handleApiError(registrationResponse.statusCode);
      }
    } catch (error) {
      handleNetworkError(error);
    }
  }

  void showError(String message) {
    setState(() {
      errorMessage = message;
    });
  }

  void handleApiError(int statusCode) {
    print('Lỗi API: $statusCode');
    showError('Đăng ký thất bại. Vui lòng thử lại.');
  }

  void handleNetworkError(dynamic error) {
    print('Lỗi: $error');
    showError('Đã xảy ra lỗi. Vui lòng thử lại sau.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng ký'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                dataValue.logo,
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  isDense: true,
                  prefixIcon: Icon(Icons.person),
                  errorText:
                      _usernameError ? 'Invalid Username Ex:songtoan123' : null,
                ),
                onChanged: (value) {
                  setState(() {
                    _usernameError = RegExp(dataValue.regex).hasMatch(value);
                  });
                },
              ),
              Text(
                errorMessage,
                style: TextStyle(color: const Color.fromARGB(255, 68, 34, 32)),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  errorText: _passwordError
                      ? 'Invalid Password Ex : songtoan123'
                      : null,
                ),
                onChanged: (value) {
                  setState(() {
                    // Regex cho mật khẩu
                    _passwordError = RegExp(dataValue.regex).hasMatch(value);
                  });
                },
              ),
              SizedBox(height: 32.0),
              TextField(
                controller: _confirmPasswordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm password',
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  onPrimary: Colors.white,
                  minimumSize: Size(80, 40),
                ),
                onPressed: () {
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  if (username.isNotEmpty &&
                      password.isNotEmpty &&
                      _confirmPasswordController.text.isNotEmpty &&
                      !_usernameError &&
                      !_passwordError) {
                    registerUser(username, password);
                  } else {
                    showError(
                        'Vui lòng nhập đầy đủ thông tin hoặc kiểm tra định dạng.');
                  }
                },
                child: Text('Đăng ký'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
