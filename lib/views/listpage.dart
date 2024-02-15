import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';


class NewsListPage extends StatelessWidget {
  static const routeName = '/article_list';

  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: FutureBuilder(future: 
      DefaultAssetBundle.of(context).loadString('assets/article.json'),
      builder: (context, snapshot) {
        final List<Article> articles = parseArticles(snapshot.data);
        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return _buildArticleItem(context, articles[index]);
          },
        );
      }, 
      ),
    );
  }

  Widget _buildArticleItem(BuildContext context, Article article){
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
        article.urlToImage,
        width: 100,
        errorBuilder: (ctx, error, _) => const Center(child: Icon(Icons.error)),
      ),
      title: Text(article.title),
      subtitle: Text(article.author),
    );
  }

  List<Article> parseArticles(String? json) {
      if(json == null) {
        return[];
      }

      final List parsed = jsonDecode(json);
      return parsed.map((json) => Article.fromJson(json)).toList();
     }
  
}

