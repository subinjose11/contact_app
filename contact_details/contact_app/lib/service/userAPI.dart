import 'dart:convert';
import 'package:contact_app/moduels/user.dart';
import 'package:http/http.dart' as http;

class UserAPI {
  // Get all user details function
  Future<List<User>?> getAllUsers() async {
    var client = http.Client();
    var url = Uri.parse("http://10.0.2.2:5000/users");
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var json = response.body;
      return userFromJson(json);
    }
  }
}
