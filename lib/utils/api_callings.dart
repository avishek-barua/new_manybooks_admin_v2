import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/after_login.dart';
import '../models/author_dummy.dart';

const API_ENDPOINT = 'http://192.168.1.143:8000';

// neo home ip
// const API_ENDPOINT = 'http://192.168.0.107:8000';

class ApiCalling {
  static Future<String?> login(AfterLogin afterLogin) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse("$API_ENDPOINT/users/login"));
    request.body = json.encode({
      "email": afterLogin.email,
      "name": afterLogin.displayName,
      "token": afterLogin.token,
      "tokenType": afterLogin.tokenType
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode < 400) {
      return await response.stream.bytesToString();
    } else {
      return null;
    }
  }
}