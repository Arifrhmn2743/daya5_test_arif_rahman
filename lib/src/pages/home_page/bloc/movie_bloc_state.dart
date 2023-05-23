part of 'movie_bloc_bloc.dart';

abstract class MovieBlocState extends Equatable {
  const MovieBlocState();

  @override
  List<Object> get props => [];
}

class MovieBlocInitial extends MovieBlocState {}

class MovieBlocLoading extends MovieBlocState {}

class LoadMoreState extends MovieBlocState {}

class MovieBlocLoaded extends MovieBlocState {
  final MovieModel movieModel;
  const MovieBlocLoaded(this.movieModel);
}

class MovieBlocError extends MovieBlocState {
  final String? message;
  const MovieBlocError(this.message);
}
