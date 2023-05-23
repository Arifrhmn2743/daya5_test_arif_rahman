import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_bloc_event.dart';
part 'movie_bloc_state.dart';

class MovieBlocBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  MovieBlocBloc() : super(MovieBlocInitial()) {
    on<MovieBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
