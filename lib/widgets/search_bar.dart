import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';

class ArticleSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(8), 
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Search articles...',
            labelStyle: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.blueAccent,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20), 
            border: InputBorder.none,
          ),
          onChanged: Provider.of<ArticleProvider>(context, listen: false).search,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
