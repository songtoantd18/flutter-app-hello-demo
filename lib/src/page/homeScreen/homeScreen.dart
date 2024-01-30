import 'package:flutter/material.dart';
import '../loginPage/loginPage.dart';
import '../changePassword/changePassword.dart';
import '../../function/website.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  // Constructor để nhận giá trị userData
  HomeScreen({
    required this.userData,
  });

  Widget _buildUserInfo() {
    return Column(
      children: userData.entries.map((entry) {
        return ListTile(
          title: Text('${entry.key}: ${entry.value}'),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white,

                // Colors.orange,
                // Colors.yellow,
                // Colors.green,
                // Colors.blue,
                // Colors.indigo,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome to the Homescreen'),
                // SizedBox(height: 20),
                _buildUserInfo(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen(
                          userId: userData['id'],
                          userPassword: userData['password'],
                        ),
                      ),
                    );
                  },
                  child: Text('Đổi mật khẩu'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text('Đăng xuất'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyWebView('https://unicjsc.com/'),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyWebView('https://www.youtube.com/'),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyWebView('https://www.24h.com.vn/'),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyWebView(
                        'https://chat.openai.com/c/e3d27b79-29e1-4487-a420-720446f3664b'),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.add_box_sharp),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyWebView('https://vtv.vn/'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
