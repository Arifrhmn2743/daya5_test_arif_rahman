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

  Future<void> addMovies(String title, String description) async {
    final formData = FormData.fromMap({
      'title': title,
      'description': description,
    });
    try {
      await _dio.post(url, data: formData);
    } catch (e) {
      throw Exception(e);
    }
  }
}
