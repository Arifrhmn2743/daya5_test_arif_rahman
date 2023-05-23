part of 'add_movie_bloc.dart';

abstract class AddMovieEvent extends Equatable {
  const AddMovieEvent();

  @override
  List<Object> get props => [];
}

class PostMovie extends AddMovieEvent {
  final String title;
  final String desc;
  const PostMovie(this.title, this.desc);
}
