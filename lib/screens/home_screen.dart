import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/shimmer_loading_widget.dart';
import '../providers/article_provider.dart';
import '../widgets/article_card.dart';
import '../widgets/search_bar.dart';
import 'detail_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Articles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite,color: Colors.red,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => FavoritesScreen()));
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: provider.fetchArticles,
        child: Column(
          children: [
            ArticleSearchBar(),
            if (provider.isLoading)
              Expanded(child: ShimmerLoadingWidget()) 
            else if (provider.errorMessage.isNotEmpty)
              Expanded(child: Center(child: Text(provider.errorMessage)))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: provider.filtered.length,
                  itemBuilder: (context, index) {
                    final article = provider.filtered[index];
                    return ArticleCard(
                      article: article,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) => DetailScreen(article: article)));
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
