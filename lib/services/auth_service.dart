import 'package:botanicalbuddy/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/config.dart';

class AuthService {
  final storage = new FlutterSecureStorage();

  Future<dynamic> signIn(String email, String password) async {
    final uri = Uri.parse(baseUrl + "/sign-in");
    final headers = {
      "Content-Type": "application/json"
    };
    Map<String, dynamic> body = {
      "email": email,
      "password": password
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    try {
      var response = await http.post(
        uri, 
        headers: headers, 
        body: jsonBody, 
        encoding: encoding
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        final user = User.fromJson(jsonDecode(response.body));
        storage.write(key: "id", value: user.id.toString());
        storage.write(key: "firstName", value: user.firstName);
        storage.write(key: "lastName", value: user.lastName);
        storage.write(key: "email", value: user.email);
        storage.write(key: "token", value: user.token);

        return user;
      }
    } catch(err) {
      print(err);
      return false;
    }
  }

  getUserFromLocalStorage() async {
    var id = await storage.read(key: "id");
    if(id == null) {
      // if the id is null we can be certain the user is not logged in
      return null;
    }

    var firstName = await storage.read(key: "firstName");
    var lastName = await storage.read(key: "lastName");
    var email = await storage.read(key: "email");
    var token = await storage.read(key: "token");

    return User(
      id: int.parse(id),
      firstName: firstName!,
      lastName: lastName!,
      email: email!,
      token: token
    );
  }

  getToken() async {
    var token = await storage.read(key: "token");
    return token;
  }

  removeToken() async {
    await storage.delete(key: "token");
  }

  Future<dynamic> signOut() async {
    final uri = Uri.parse(baseUrl + "/sign-out");
    final token = await getToken();
    if(token == null) {
      // if there is no auth token we dont need to do anything
      return true;
    }

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    };

    try {
      var response = await http.get(
        uri, 
        headers: headers
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        await removeToken();
        return true;
      }
    } catch(err) {
      print(err);
      return null;
    }
  }


  Future<dynamic> signUp(firstName, lastName, email, password) async {
    final uri = Uri.parse(baseUrl + "/sign-up");
    final headers = {
      "Content-Type": "application/json"
    };
    Map<String, dynamic> body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    var response = await http.post(
      uri, 
      headers: headers, 
      body: jsonBody, 
      encoding: encoding
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return false;
    }
  }
}