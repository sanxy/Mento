import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:mento/models/user.dart';

class UserService {
  static Future browse() async {
    List? collection;
    List<User>? _contacts;

    Map<String, String> header = <String, String>{
      "userid": "25794905-2dd4-40bd-97b9-9d5d69294b86",
      "token": "d61036c6-5ffd-4964-b7ff-8d5ba8ca0262"
    };

    var url = Uri.https(
        'utkwwq6r95.execute-api.us-east-1.amazonaws.com', '/assignment/topics');
    var response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      collection = convert.jsonDecode(response.body);
      _contacts = collection!.map((json) => User.fromJson(json)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return _contacts;
  }
}
