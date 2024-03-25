import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/views/article_detail_page.dart';
import 'package:news_app/widgets/platform_widget.dart';


class ArticleListPage extends StatelessWidget {
  const ArticleListPage({super.key});

  List<Article> parseArticles(String? json) {
      if(json == null) {
        return[];
      }

      final List parsed = jsonDecode(json);
      return parsed.map((json) => Article.fromJson(json)).toList();
     }

  FutureBuilder<String> _buildList(BuildContext context) {
    return FutureBuilder(future: 
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
    );
  }

  Widget _buildArticleItem(BuildContext context, Article article){
    return Material(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: article.urlToImage,
          child: Image.network(
            article.urlToImage,
            width: 100,
            errorBuilder: (ctx, error, _) => const Center(child: Icon(Icons.error)),
          ),
        ),
        title: Text(article.title),
        subtitle: Text(article.author),
        onTap: () {
          Navigator.pushNamed(context, ArticleDetailPage.routeName,
          arguments: article);
        },
      ),
    );
  }

     Widget _buildAndroid(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: const Text('News App'),
        ),
        body: _buildList(context),
      );
     }

     Widget _buildIos(BuildContext context){
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('News App'),
          transitionBetweenRoutes: false,
          ),
          child: _buildList(context)
      );
     }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid, 
      iosBuilder: _buildIos);
  }
}

