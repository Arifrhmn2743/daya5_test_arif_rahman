import 'package:bloc/bloc.dart';
import 'package:daya5_test_arif_rahman/src/model/movie_model.dart';
import 'package:daya5_test_arif_rahman/src/repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'movie_bloc_event.dart';
part 'movie_bloc_state.dart';

class MovieBlocBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  MovieBlocBloc() : super(MovieBlocInitial()) {
    final MovieRepository movieRepository = MovieRepository();

    on<MovieFetched>((event, emit) async {
      try {
        emit(MovieBlocLoading());
        final list = await movieRepository.getMovies(1);
        emit(MovieBlocLoaded(list));
      } catch (e) {
        emit(const MovieBlocError("Error"));
      }
    });
  }
}
