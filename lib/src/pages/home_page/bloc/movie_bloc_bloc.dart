import 'package:bloc/bloc.dart';
import 'package:daya5_test_arif_rahman/src/model/movie_model.dart';
import 'package:daya5_test_arif_rahman/src/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'movie_bloc_event.dart';
part 'movie_bloc_state.dart';

class MovieBlocBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  ScrollController controller = ScrollController();
  int currentPage = 1;
  bool isLoadingMore = false;
  MovieBlocBloc() : super(MovieBlocInitial()) {
    final MovieRepository movieRepository = MovieRepository();

    on<MovieFetched>((event, emit) async {
      try {
        emit(MovieBlocLoading());
        final list = await movieRepository.getMovies(currentPage);
        emit(MovieBlocLoaded(list));
      } catch (e) {
        emit(const MovieBlocError("Error"));
      }
    });

    on<LoadMoreMovie>((event, emit) async {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        emit(LoadMoreState());
        currentPage++;
        final posts = await movieRepository.getMovies(currentPage);
        emit(MovieBlocLoaded(posts));

        //  isLoadingMore = false;
      } else {
        print("not called");
        print(currentPage);
      }
    });
  }
}
