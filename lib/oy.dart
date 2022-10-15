// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps

library oy;

import 'dart:convert';

import 'package:http/http.dart';

enum OyEnvironmentType { live, sandbox }

class Oy {
  late String url_api_sandbox = "https://api-stg.oyindonesia.com";
  late String url_api_live = "https://partner.oyindonesia.com";
  late OyEnvironmentType oy_environment_type;
  Oy({
    OyEnvironmentType oyEnvironmentType = OyEnvironmentType.sandbox,
  }) {
    oy_environment_type = oyEnvironmentType;
  }
  Future<Response> invoke({
    required String method,
    required String username,
    required String api_key,
    Map? parameter,
    OyEnvironmentType? oyEnvironmentType,
  }) async {
    oyEnvironmentType ??= oy_environment_type;
    String url_api = url_api_sandbox;
    if (oyEnvironmentType == OyEnvironmentType.live) {
      url_api = url_api_live;
    }
    late Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-oy-username': username,
      'x-api-key': api_key,
    };
    Uri url = Uri.parse("${url_api}${method}");
    return await post(url, headers: headers, body: json.encode(parameter));
  }
}
