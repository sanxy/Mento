import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mento/models/mento_model.dart';
import 'package:mento/resources/api_repository.dart';

part 'mento_event.dart';
part 'mento_state.dart';

class MentoBloc extends Bloc<MentoEvent, MentoState> {
  MentoBloc() : super(MentoInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetCovidList>((event, emit) async {
      try {
        emit(MentoLoading());
        final mList = await _apiRepository.fetchCovidList();
        emit(MentoLoaded(mList));
        if (mList.error != null) {
          emit(MentoError(mList.error));
        }
      } on NetworkError {
        emit(MentoError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
