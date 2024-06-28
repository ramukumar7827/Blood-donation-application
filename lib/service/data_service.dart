import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class DataService {
  String baseUrl = 'http://localhost:5000/api';
  var log = Logger();

  String formatter(String url) {
    return baseUrl + url;
  }

  Future<http.Response> get(String url) async {
    try {
      formatter(url);
      var response = await http.post(Uri.parse(url));

      // Log response details
      print('Response: ${response.body}');
      print('Status Code: ${response.statusCode}');

      return response;
    } catch (e) {
      print('Error: $e');
      throw e; // Rethrow the error for handling in _onSubmit
    }
  }

  Future<dynamic> loginUser(String url, Map<String, String> body) async {
    try {
      url = formatter(url);
      var response = await http.post(Uri.parse(url),
          headers: {"Content-type": "application/json"},
          body: json.encode(body));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        log.e('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log.e('Error:$e');
      return null;
    }
  }

  Future<dynamic> post(String url, Map<String, String> body) async {
    try {
      url = formatter(url);

      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-type": "application/json"},
        body: json.encode(body),
      );

      return response.body;
        } catch (e) {
      log.e('Error: $e');
      return null;
    }
  }

  Future<dynamic> becomedonor(String url, Map<String, String> data) async {
    try {
      url = formatter(url);
      var response = await http.post(Uri.parse(url),
          headers: {"Content-type": "application/json"},
          body: json.encode(data));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        log.e('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {}
  }
}
