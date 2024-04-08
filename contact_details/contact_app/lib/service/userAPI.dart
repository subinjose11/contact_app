import 'dart:convert';
import 'package:contact_app/moduels/user.dart';
import 'package:http/http.dart' as http;

class UserAPI {
  // Get all contact details function
  Future<List<User>?> getAllUsers() async {
    var client = http.Client();
    var url = Uri.parse("http://10.0.2.2:5000/users");
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var json = response.body;
      return userFromJson(json);
    }
  }

  //Adding new contact
  Future<User> addUser(String name, String contact) async {
    var client = http.Client();
    var url = Uri.parse("http://10.0.2.2:5000/users");
    final http.Response response = await client.post(url,
        headers: <String, String>{
          'content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{'name': name, 'contact': contact}));

    if (response.statusCode == 200) {
      var json = response.body;
      return User.fromJson(jsonDecode(json));
    } else {
      throw Exception('failed to add contact');
    }
  }

//Deleteing contact
  Future<User> deleteUser(int id) async {
    var client = http.Client();
    var url = Uri.parse("http://10.0.2.2:5000/users/$id");
    final http.Response response = await client.delete(
      url,
      headers: <String, String>{
        'content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 200) {
      var json = response.body;
      return User.fromJson(jsonDecode(json));
    } else {
      throw Exception('failed to delete contact');
    }
  }

  //Updating contact
  Future<User> updateUser(String name, String contact, int id) async {
    var client = http.Client();
    var url = Uri.parse("http://10.0.2.2:5000/users/$id");
    final http.Response response = await client.put(url,
        headers: <String, String>{
          'content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{'name': name, 'contact': contact}));

    if (response.statusCode == 200) {
      var json = response.body;
      return User.fromJson(jsonDecode(json));
    } else {
      throw Exception('failed to update contact');
    }
  }
}
