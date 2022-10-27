part of 'mento_bloc.dart';

abstract class MentoEvent extends Equatable {
  const MentoEvent();

  @override
  List<Object> get props => [];
}

class GetCovidList extends MentoEvent {}
