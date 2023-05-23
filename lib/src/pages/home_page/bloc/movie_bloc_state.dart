part of 'movie_bloc_bloc.dart';

abstract class MovieBlocState extends Equatable {
  const MovieBlocState();
  
  @override
  List<Object> get props => [];
}

class MovieBlocInitial extends MovieBlocState {}
