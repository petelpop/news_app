import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/views/detailpage.dart';
import 'package:news_app/views/listpage.dart';
import 'package:news_app/views/webview.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: NewsListPage.routeName,
      routes: {
        NewsListPage.routeName:(context) => const NewsListPage(),
        ArticleDetailPage.routeName: (context) => ArticleDetailPage(
          article: ModalRoute.of(context)?.settings.arguments as Article,
        ),
        ArticleWebView.routeName:(context) => ArticleWebView(
          url: ModalRoute.of(context)?.settings.arguments as String,
        )
      },
    );
  }
}
