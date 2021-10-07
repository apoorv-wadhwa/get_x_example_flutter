import 'dart:convert';

import 'package:http/http.dart' as http;

class QuotesRepository {
  Future<Map<String,dynamic>> getQuote() async {
    try{
      http.Response response = await http.get(Uri.parse("http://quotes.rest/qod.json?category=inspire"));
      print('response body is ${response.body}');
      print('response body runtimetype is ${response.body.runtimeType}');
      print('response body is ${jsonDecode(response.body)}');
      print('jsondecode response body runtimetype is ${jsonDecode(response.body).runtimeType}');
      final Map<String,dynamic> map = Map.from(jsonDecode(response.body));
      return map;
      
    }
    catch(error) {
      print('QuotesRepository getQuote error $error');
      return null;
    }
  }
}