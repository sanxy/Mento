import 'package:mento/models/mento_model.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<MentoModel> fetchCovidList() {
    return _provider.fetchCovidList();
  }
}

class NetworkError extends Error {}
