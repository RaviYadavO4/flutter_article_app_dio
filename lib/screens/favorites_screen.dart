import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import '../widgets/article_card.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Favorites"),backgroundColor: Colors.white,),
      body: provider.favorites.isEmpty
          ? const Center(child: Text("No favorites yet"))
          : ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                final article = provider.favorites[index];
                return ArticleCard(
                  article: article,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) => DetailScreen(article: article)));
                  },
                );
              },
            ),
    );
  }
}
