part of 'add_movie_bloc.dart';

abstract class AddMovieEvent extends Equatable {
  const AddMovieEvent();

  @override
  List<Object> get props => [];
}

class PostMovieWithPoster extends AddMovieEvent {
  final String title;
  final String desc;
  final File? poster;
  const PostMovieWithPoster(this.title, this.desc, this.poster);
}

class PostMovie extends AddMovieEvent {
  final String title;
  final String desc;
  const PostMovie(this.title, this.desc);
}
