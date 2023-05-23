part of 'movie_bloc_bloc.dart';

abstract class MovieBlocEvent extends Equatable {
  const MovieBlocEvent();

  @override
  List<Object> get props => [];
}

class MovieFetched extends MovieBlocEvent {}

class LoadMoreMovie extends MovieBlocEvent {}
