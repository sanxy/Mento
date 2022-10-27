import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mento/models/mento_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url =
      'https://utkwwq6r95.execute-api.us-east-1.amazonaws.com/assignment/topics';
  // final String _url = 'https://api.covid19api.com/summary';

  Future<MentoModel> fetchCovidList() async {
    try {
      _dio.options.headers['userid'] = '25794905-2dd4-40bd-97b9-9d5d69294b86';
      _dio.options.headers['token'] = 'd61036c6-5ffd-4964-b7ff-8d5ba8ca0262';
      Response response = await _dio.get(_url);

      print('Response::: ${response.data}');
      print('Response 0::: ${response.data.runtimeType}');
      print('Response 0::: ${response.data[0]}');

      List listOne = [];
      Map<String, dynamic> paket = {};
      Map<String, dynamic> recipeList = {};

      for (final e in response.data) {
        listOne.add(e);
        paket.addAll(e);
        // recipeList.add(e);
        // print('List::: $e');
      }

      // final map = listOne.asMap();

      var mapTwo = {};

      for (var element in listOne) {
        // mapTwo.update(element);
        // print('Response 0::: ${element}');
      }

      print('Response 00000::: ${mapTwo.length}');
      print('Response 00000::: ${mapTwo}');

      // Map<String, dynamic> map = listOne as Map<String, dynamic>;

      // Map<String, dynamic> responseData = json.decode(response.data);

      // print('Response 002::: ${paket.length}');
      // print('Response 003::: ${paket.runtimeType}');
      // print('Response 033::: ${map}');
      //
      // print('Response 004::: ${listOne.length}');
      // print('Response 005::: ${listOne}');

      final rawProductsList = response.data as List? ?? [];
      // final productsList =
      //     rawProductsList.map((rawProduct) => MentoModel.fromJson(map));
      //
      // print('Response 004::: ${productsList.length}');

      return MentoModel.fromJson(response.data);
      // return MentoModel.fromJson(paket);
      // return MentoModel.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MentoModel.withError("Data not found / Connection issue");
    }
  }
}
