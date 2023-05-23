import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repository/repository.dart';

part 'add_movie_event.dart';
part 'add_movie_state.dart';

class AddMovieBloc extends Bloc<AddMovieEvent, AddMovieState> {
  AddMovieBloc() : super(AddMovieInitial()) {
    final MovieRepository movieRepository = MovieRepository();
    on<PostMovie>((event, emit) async {
      emit(AddingMovies());
      await Future.delayed(const Duration(seconds: 2));
      try {
        await movieRepository.addMovies(event.title, event.desc);
        emit(AddedMovies());
      } catch (e) {
        emit(AddMovieError(e.toString()));
      }
    });
    on<PostMovieWithPoster>((event, emit) async {
      emit(AddingMovies());
      await Future.delayed(const Duration(seconds: 2));
      try {
        await movieRepository.addMoviesWithPhoto(
            event.title, event.desc, event.poster);
        emit(AddedMovies());
      } catch (e) {
        emit(AddMovieError(e.toString()));
      }
    });
  }
}
