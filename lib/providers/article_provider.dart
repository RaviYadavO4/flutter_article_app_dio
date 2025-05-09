import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/article.dart';
import '../services/api_service.dart';

class ArticleProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Article> _articles = [];
  List<Article> get articles => _articles;

  List<Article> _favorites = [];
  List<Article> get favorites => _favorites;

  List<Article> _filtered = [];
  List<Article> get filtered => _filtered;

  bool isLoading = false;
  String errorMessage = '';

  ArticleProvider() {
    loadFavorites();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    isLoading = true;
    notifyListeners();

    try {
      _articles = await _apiService.fetchArticles();
      _filtered = _articles;
      errorMessage = '';
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void search(String query) {
    _filtered = _articles.where((article) {
      return article.title.toLowerCase().contains(query.toLowerCase()) ||
             article.body.toLowerCase().contains(query.toLowerCase());
    }).toList();
    notifyListeners();
  }

  void toggleFavorite(Article article) {
    if (_favorites.any((a) => a.id == article.id)) {
      _favorites.removeWhere((a) => a.id == article.id);
    } else {
      _favorites.add(article);
    }
    saveFavorites();
    notifyListeners();
  }

  bool isFavorite(int id) => _favorites.any((a) => a.id == id);

  Future<void> loadFavorites() async {
    final box = await Hive.openBox('favorites');
    final ids = box.get('ids', defaultValue: <int>[]);
    _favorites = _articles.where((a) => ids.contains(a.id)).toList();
    notifyListeners();
  }

  Future<void> saveFavorites() async {
    final box = await Hive.openBox('favorites');
    await box.put('ids', _favorites.map((a) => a.id).toList());
  }
}
