import 'package:flutter/material.dart'; // Import necessary packages
import 'dart:convert';
import 'actionApi.dart';
import '../page/homeScreen/homeScreen.dart';

Future<void> handleLogin(
    BuildContext context, // Add BuildContext as a parameter
    String username,
    String password,
    String apiUrl,
    Function setStateCallback) async {
  // Add a callback function for setState

  try {
    // Lấy đường dẫn API từ giá trị dataValue
    final apiUrlValue = apiUrl; // Assuming dataValue is accessible

    // Thực hiện một yêu cầu GET đến đường dẫn API đã xác định
    final response = await getApi(apiUrlValue);

    if (response.statusCode == 200) {
      // Nếu mã trạng thái của phản hồi là 200 (OK), phân tích cú pháp JSON của phản hồi
      final List<dynamic> users = json.decode(response.body);
      print(response.body);
      print('Đây là người dùng: $users');

      // Duyệt qua danh sách người dùng nhận được từ phản hồi API
      Map<String, dynamic> userData = {};
      for (var user in users) {
        // Kiểm tra xem tên người dùng và mật khẩu có khớp với bất kỳ người dùng nào trong danh sách hay không
        if (user['userName'] == username && user['password'] == password) {
          // Nếu tìm thấy khớp, gán giá trị cho userData
          userData = user;
          break; // Dừng vòng lặp nếu đã tìm thấy người dùng
        }
      }

      if (userData.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              userData: userData,
            ),
          ),
        );
      } else {
        setStateCallback();
      }
    } else {
      // Nếu mã trạng thái của phản hồi không phải là 200, in một thông báo lỗi
      print('Lỗi API: ${response.statusCode}');
      // Xử lý lỗi theo ý của bạn
    }
  } catch (error) {
    // Nếu có ngoại lệ xảy ra trong quá trình thực hiện, in một thông báo lỗi
    print('Lỗi: $error');
    // Xử lý lỗi theo ý của bạn
  }
}
