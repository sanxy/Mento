import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localstore/localstore.dart';
import 'package:mento/models/todo.dart';
import 'package:mento/screen/create_page.dart';
import '../bloc/user_bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserBLoC userBLoC = UserBLoC();
  String? textName;
  final _db = Localstore.instance;
  final _items = <String, Todo>{};
  StreamSubscription<Map<String, dynamic>>? _subscription;

  @override
  void initState() {
    _subscription = _db.collection('todos').stream.listen((event) {
      setState(() {
        final item = Todo.fromMap(event);
        _items.putIfAbsent(item.id, () => item);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Mock Test App',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
              )),
          const SizedBox(
            height: 30,
          ),
          SvgPicture.asset(
            'assets/images/main.svg',
            height: 200.0,
            width: 200.0,
          ),
          Container(
              margin: const EdgeInsets.only(
                  top: 20.0, left: 60.0, right: 60.0, bottom: 30.0),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // background
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0), // foreground
                    elevation: 1.0),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          CreatePage(title: 'Create New Test')));
                },
                child: const Text('Create New Test',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              )),
          Divider(thickness: 4, color: Colors.blue),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _items.keys.length,
                    itemBuilder: (context, index) {
                      final key = _items.keys.elementAt(index);
                      final item = _items[key]!;
                      // print('Data retrieved::: ${_items.keys.length}');
                      return Container(
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
                        padding: const EdgeInsets.only(left: 20.0, right: 40.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              item.title,
                              style: const TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Created on: ',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    TextSpan(
                                      text: item.time,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
