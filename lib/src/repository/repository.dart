import 'package:daya5_test_arif_rahman/src/model/movie_model.dart';
import 'package:dio/dio.dart';

class MovieRepository {
  static String url = "https://dlabs-test.irufano.com/api/movie";
  final Dio _dio = Dio();

  Future<MovieModel> getMovies(int page) async {
    var params = {"size": 10, "page": page};
    try {
      Response response = await _dio.get(url, queryParameters: params);
      return MovieModel.fromJson(response.data);
    } catch (error, stacktrace) {
      return MovieModel.withError(
          "Data not found, $error stackTrace: $stacktrace");
    }
  }
}
