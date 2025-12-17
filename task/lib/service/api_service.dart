import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task/utils/app_utils.dart';

class ApiService {

  Future<T> makeGetRequest<T>(
    T Function(dynamic json) fromJson,
    BuildContext? context,
  ) async {
    try {
      const String url = 'https://jsonplaceholder.typicode.com/posts';
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return fromJson(data);
      }

      if (response.statusCode == 400) {
        AppUtils.showToast(data['message'] ?? 'An error occurred');
        throw Exception('Bad Request');
      }

      if (response.statusCode == 404) {
         AppUtils.showToast("Page Not Found");
        throw Exception("Page Not Found");
      }
      if (response.statusCode == 500) {
         AppUtils.showToast("Internal Server Error");
        throw Exception("Internal Server Error");
      }

      throw Exception('Status code: ${response.statusCode}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
