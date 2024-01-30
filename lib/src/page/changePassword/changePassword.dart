import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../loginPage/loginPage.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String userId;
  final String userPassword;

  ChangePasswordScreen({required this.userId, required this.userPassword});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _oldPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Old Password'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirm Password'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen,
                onPrimary: Colors.white,
              ),
              onPressed: () async {
                String oldPasswordInput = _oldPasswordController.text;
                String newPasswordInput = _newPasswordController.text;
                String newConfirmPasswordInput =
                    _confirmPasswordController.text;
                String userId = widget.userId;
                String userPassword = widget.userPassword;

                if (oldPasswordInput != userPassword) {
                  _showSnackbar('Sai Mật Khẩu Cũ', context);
                } else if (newPasswordInput != newConfirmPasswordInput) {
                  _showSnackbar('Mật Khẩu Không Trùng Khớp', context);
                } else {
                  try {
                    final response = await http.put(
                      Uri.parse(
                          'https://62fbae6be4bcaf53518af2ed.mockapi.io/api/users/$userId'),
                      body: {'password': newPasswordInput},
                    );

                    if (response.statusCode == 200) {
                      _showSnackbar(
                          'Mật Khẩu Đã Được Cập Nhật Thành Công', context);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    } else {
                      _showSnackbar('Cập Nhật Mật Khẩu Thất Bại', context);
                    }
                  } catch (error) {
                    _showSnackbar('Lỗi Cập Nhật Mật Khẩu: $error', context);
                  }
                }
              },
              child: Text('Đổi Mật Khẩu'),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showSnackbar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
