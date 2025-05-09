import 'package:dio/dio.dart';
import '../models/article.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  final Dio _dio = Dio();

  Future<List<Article>> fetchArticles() async {
    try {
      final response = await _dio.get(_baseUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load articles: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        throw Exception('Connection timeout. Please try again later.');
      } else if (e.type == DioErrorType.sendTimeout) {
        throw Exception('Send timeout. Please try again later.');
      } else if (e.type == DioErrorType.receiveTimeout) {
        throw Exception('Receive timeout. Please try again later.');
      } else if (e.type == DioErrorType.badResponse) {
        throw Exception('Server responded with an error: ${e.response?.statusCode}');
      } else if (e.type == DioErrorType.cancel) {
        throw Exception('Request was cancelled.');
      } else if (e.type == DioErrorType.unknown) {
        throw Exception('Something went wrong. Please check your connection.');
      } else {
        throw Exception('Unexpected error occurred.');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
