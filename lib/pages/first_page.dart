import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/mento_model.dart';

class FirstPage extends StatelessWidget {
  DataRepository dataRepository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<DataListCubit>(
        create: (context) => DataListCubit(dataRepository),
        child: Scaffold(
          body: BlocBuilder<DataListCubit, DataListState>(
            builder: (context, state) {
              print(state.data);
              if (state.data.isNotEmpty) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    for (Map<String, dynamic> ff in state.data)
                      ListTile(
                        title: Text(ff['name']),
                        leading: Text(ff['id'].toString()),
                      ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('No Data'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class DataRepository {
  DataRepository() {
    getData();
  }

  DataApi dataApi = DataApi();
  List<Map<String, dynamic>> formattedData = [];
  final _controller = StreamController<List<Map<String, dynamic>>>();

  Future<void> getData() async {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      var el = dataApi.fetchMentoList();

      print('Data::: ${el}');
      print('Data 0::: ${el.runtimeType}');
      // formattedData.add({'id': el['id'], 'name': el['name']});
      // _controller.add(formattedData);

      // Map<String, dynamic> el = dataApi.getNew();
      // formattedData.add({'id': el['id'], 'name': el['name']});
      // _controller.add(formattedData);
    });
  }

  Stream<List<Map<String, dynamic>>> data() async* {
    yield* _controller.stream;
  }

  void dispose() => _controller.close();
}

class DataApi {
  var rng = Random();
  final Dio _dio = Dio();
  final String _url =
      'https://utkwwq6r95.execute-api.us-east-1.amazonaws.com/assignment/topics';

  getNew() {
    var rnd = rng.nextInt(10);
    return {"id": rnd, "name": "Person " + rnd.toString()};
  }

  fetchMentoList() async {
    try {
      _dio.options.headers['userid'] = '25794905-2dd4-40bd-97b9-9d5d69294b86';
      _dio.options.headers['token'] = 'd61036c6-5ffd-4964-b7ff-8d5ba8ca0262';
      Response response = await _dio.get(_url);

      // print('Response::: ${response.data}');
      // print('Response 0::: ${response.data.runtimeType}');
      // print('Response 0::: ${response.data[0]}');

      List listOne = [];

      for (final e in response.data) {
        listOne.add(e);
      }

      return listOne;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MentoModel.withError("Data not found / Connection issue");
    }
  }
}

class DataListState {
  const DataListState(this.data);

  final List<Map<String, dynamic>> data;

  DataListState copyWith({
    List<Map<String, dynamic>>? data,
  }) {
    return DataListState(
      data ?? this.data,
    );
  }
}

class DataListCubit extends Cubit<DataListState> {
  DataListCubit(this.dataRepository) : super(DataListState([])) {
    loadList();
  }

  final DataRepository dataRepository;

  loadList() {
    dataRepository.data().listen((event) {
      if (event.isNotEmpty) {
        emit(state.copyWith(data: dataRepository.formattedData));
      }
    });
  }
}
