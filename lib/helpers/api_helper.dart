import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class ApiHelper{
  Future<String> getFavicon(String website) async {
    var url =
    Uri.https('favicongrabber.com', 'api/grab/$website');
    var response = await http.get(url);
    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;
    return jsonResponse['icons'][0]['src'];
  }
}