import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:libraria_news_application/core/error/exception.dart';
import 'package:libraria_news_application/core/features/news/data/models/article_model.dart';

abstract class ArticleRemoteDataSource {
  ///Calls the https://news.libraria.com.br/wp-json/wp/v2/posts?page={page} endpoint
  ///
  ///Throws a [ServerException] for all errors codes.
  Future<List<ArticleModel>> getListArticles({int page});

  ///Calls the https://news.libraria.com.br/wp-json/wp/v2/posts?search=$query endpoint
  ///
  ///Throws a [ServerException] for all errors codes.
  Future<List<ArticleModel>> searchArticles({String? query});

  ///Calls the news url when user press the specific article
  ///
  ///Throws a [ServerException] for all errors codes.
  Future<String> getSingleArticle({String url});
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final http.Client client;

  ArticleRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ArticleModel>> getListArticles({int page = 1}) async {
    final response = await client.get(Uri.parse('https://news.libraria.com.br/wp-json/wp/v2/posts?page=$page'));
    if (response.statusCode == 200) {
      return parseArticles(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ArticleModel>> searchArticles({String? query}) async {
    final response = await client.get(Uri.parse('https://news.libraria.com.br/wp-json/wp/v2/posts?search=$query'));
    if (response.statusCode == 200) {
      return parseArticles(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> getSingleArticle({String url = ''}) {
    throw UnimplementedError();
  }

  List<ArticleModel> parseArticles(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<ArticleModel>((json) => ArticleModel.fromJson(json)).toList();
  }
}
