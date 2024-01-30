import 'package:flutter/material.dart';
import 'dart:convert';
import '../../constants/data.dart';
import '../../function/actionApi.dart';
import '../../function/loadingFunction.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quên mật khẩu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hiển thị logo
            Container(
              width: 200,
              height: 200,
              child: Image.network(
                dataValue.logo,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 16.0),
            // Giao diện của trang quên mật khẩu
            Text(
              'Nhập Username để đặt lại mật khẩu',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _userNameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 25.0),

            ElevatedButton(
              onPressed: () async {
                LoadingUtils.showLoadingWithProgress(context);
                String userName = _userNameController.text;

                Future.delayed(Duration(milliseconds: 0), () async {
                  DateTime startTime = DateTime.now();
                  final apiUrl = dataValue.apiUrl;
                  final response = await await getApi(apiUrl);
                  DateTime endTime = DateTime.now();
                  Duration elapsedTime = endTime.difference(startTime);
                  print(
                      "Thời gian trôi qua 1  1 1: ${elapsedTime.inMilliseconds} ms");

                  if (response.statusCode == 200) {
                    final List<dynamic> users = json.decode(response.body);
                    var user = users.firstWhere(
                      (user) => user['userName'] == userName,
                      orElse: () => null,
                    );

                    if (user != null) {
                      String password = user['password'];
                      showPasswordDialog(context, password);
                    } else {
                      showNotFoundDialog(context);
                    }
                  } else {
                    showApiErrorDialog(context);
                  }
                });
              },
              child: Text('Gửi yêu cầu'),
            ),
          ],
        ),
      ),
    );
  }

  void showPasswordDialog(BuildContext context, String password) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thông báo'),
        content: Text('Mật khẩu của bạn là: $password'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void showNotFoundDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thông báo'),
        content: Text('Không tìm thấy người dùng với userName này.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void showApiErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Lỗi'),
        content: Text('Đã xảy ra lỗi khi truy xuất dữ liệu từ API.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
