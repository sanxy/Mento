import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstore/localstore.dart';
import 'package:mento/bloc/user_bloc.dart';
import 'package:mento/models/todo.dart';
import 'package:mento/models/user.dart';
import 'package:parent_child_checkbox/parent_child_checkbox.dart';

class CreatePage extends StatefulWidget {
  CreatePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  UserBLoC userBLoC = UserBLoC();
  String? textName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Test'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: TextFormField(
              autofocus: true,
              initialValue: '',
              // textInputAction: TextInputAction.done,
              // onSaved: (value) => setState(() => amount = value!),

              onChanged: (value) => setState(() {
                print('Raw value:::: $value');
                textName = value;
              }),
              style: TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlue)),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.perm_contact_cal_outlined),
              ),
              validator: (value) {
                if (value!.isEmpty) return 'Test Name is required';

                return null;
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: userBLoC.usersList,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                      return Center();
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text('There was an error : ${snapshot.error}');
                      }
                      List<User>? users = snapshot.data;

                      return Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 40.0,
                            child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    'Topics',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue),
                                  ),
                                )),
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemCount: users?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                User user = users![index];

                                // print('Users::: ${users.length}');

                                return Container(
                                  child: ParentChildCheckbox(
                                    parent: Text(user.topicName!),
                                    parentCheckboxColor: Colors.orange,
                                    childrenCheckboxColor: Colors.red,
                                    children: [
                                      for (var item in user.concepts!)
                                        Text(item)
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => Divider(),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                  top: 10,
                                  left: 40.0,
                                  right: 40.0,
                                  bottom: 30.0),
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue, // background
                                    foregroundColor: Colors.white, // foreground
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: const EdgeInsets.only(
                                        top: 20.0, bottom: 20.0),
                                    elevation: 1.0),
                                onPressed: () async {
                                  if (textName!.isEmpty) {
                                    print('Text name is empty');
                                  } else {
                                    print('Text name::: $textName');

                                    final id = Localstore.instance
                                        .collection('todos')
                                        .doc()
                                        .id;
                                    final now = DateTime.now();
                                    final item = Todo(
                                      id: id,
                                      title: textName!,
                                      time:
                                          "${DateFormat.yMMMMd().format(now)} ${DateFormat.jm().format(now)}",
                                      done: false,
                                    );
                                    item.save();

                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('Create',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white)),
                              )),
                        ],
                      );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
