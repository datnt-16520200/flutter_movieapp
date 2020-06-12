import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApiClient{
  static String _baseURL = "http://127.0.0.1:8000/";

  static Future<Map<String, dynamic>> Login(String user_name, String password) async {
    http.Response response = await http.post(
        "http://10.0.2.2:8000/api/login",
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String,String>{
        'user_name': user_name,
        'password': password
      })
    );

    Map<String, dynamic> res_data = json.decode(response.body);

    return res_data;
  }
}