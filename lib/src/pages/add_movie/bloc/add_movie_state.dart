part of 'add_movie_bloc.dart';

abstract class AddMovieState extends Equatable {
  const AddMovieState();

  @override
  List<Object> get props => [];
}

class AddMovieInitial extends AddMovieState {}

class AddingMovies extends AddMovieState {
  @override
  List<Object> get props => [];
}

class AddedMovies extends AddMovieState {
  @override
  List<Object> get props => [];
}

class AddMovieError extends AddMovieState {
  final String error;

  const AddMovieError(this.error);
  @override
  List<Object> get props => [error];
}
