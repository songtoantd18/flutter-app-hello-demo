import 'package:http/http.dart' as http;

Future<http.Response> getApi(String url) async {
  return await http.get(Uri.parse(url));
}

Future<http.Response> postApi(String url, Map<String, dynamic> data) async {
  return await http.post(Uri.parse('$url'), body: data);
}
