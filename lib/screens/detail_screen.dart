import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../providers/article_provider.dart';

class DetailScreen extends StatelessWidget {
  final Article article;

  const DetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Article Detail'),
        actions: [
          IconButton(
            icon: Icon(
              provider.isFavorite(article.id) ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () => provider.toggleFavorite(article),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(article.title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(article.body),
          ],
        ),
      ),
    );
  }
}
