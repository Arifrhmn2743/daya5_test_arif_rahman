import 'package:daya5_test_arif_rahman/src/model/movie_model.dart';
import 'package:daya5_test_arif_rahman/src/pages/detail_page/detail_page.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/movie_bloc_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieBlocBloc _movieBlocBloc = MovieBlocBloc();

  @override
  void initState() {
    _movieBlocBloc.add(MovieFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 172, 171, 171),
        appBar: AppBar(
          title: const Text("Movie List"),
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (_) => _movieBlocBloc,
            child: BlocListener<MovieBlocBloc, MovieBlocState>(
              listener: (context, state) {
                if (state is MovieBlocError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message!),
                    ),
                  );
                }
              },
              child: BlocBuilder<MovieBlocBloc, MovieBlocState>(
                builder: (context, state) {
                  if (state is MovieBlocInitial) {
                    return _buildLoading();
                  } else if (state is MovieBlocLoading) {
                    return _buildLoading();
                  } else if (state is MovieBlocLoaded) {
                    return _buildCard(context, state.movieModel,
                        context.read<MovieBlocBloc>().controller, state);
                  } else if (state is MovieBlocError) {
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ));
  }

  Widget _buildCard(BuildContext context, MovieModel model,
      ScrollController controller, MovieBlocState state) {
    return ListView.builder(
      controller: controller
        ..addListener(() {
          _movieBlocBloc.add(LoadMoreMovie());
        }),
      // itemCount: model.data!.length,
      itemCount:
          state is LoadMoreState ? model.data!.length + 1 : model.data!.length,
      itemBuilder: (context, index) {
        if (index < model.data!.length) {
          final test = model.data![index];
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        title: test.title.toString(),
                        desc: test.description.toString(),
                        poster: test.poster.toString(),
                      ),
                    ));
              },
              child: Card(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      FancyShimmerImage(
                        width: 100,
                        height: 100,
                        imageUrl: test.poster.toString(),
                        errorWidget: Image.network(
                            'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          " ${test.title}",
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
