part of 'mento_bloc.dart';

abstract class MentoState extends Equatable {
  const MentoState();

  @override
  List<Object?> get props => [];
}

class MentoInitial extends MentoState {}

class MentoLoading extends MentoState {}

class MentoLoaded extends MentoState {
  final MentoModel mentoModel;
  const MentoLoaded(this.mentoModel);
}

class MentoError extends MentoState {
  final String? message;
  const MentoError(this.message);
}
