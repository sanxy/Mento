import 'dart:async';
import 'package:mento/models/user.dart';
import 'package:mento/services/users_service.dart';

class UserBLoC {
  Stream<List<User>> get usersList async* {
    yield await UserService.browse();
  }

  final StreamController<int> _userCounter = StreamController<int>();

  Stream<int> get userCounter => _userCounter.stream;

  UserBLoC() {
    usersList.listen((list) => _userCounter.add(list.length));
  }
}
