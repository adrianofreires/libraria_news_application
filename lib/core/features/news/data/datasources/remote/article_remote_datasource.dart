import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:libraria_news_application/core/error/exception.dart';
import 'package:libraria_news_application/core/features/news/data/models/article_model.dart';
import 'package:libraria_news_application/core/features/news/data/models/category_model.dart';
import 'package:libraria_news_application/core/features/news/domain/entities/category.dart';

abstract class ArticleRemoteDataSource {
  ///Calls the https://news.libraria.com.br/wp-json/wp/v2/posts?page={page} endpoint
  ///
  ///Throws a [ServerException] for all errors codes.
  Future<List<ArticleModel>> getListArticles({int page});

  ///Calls the https://news.libraria.com.br/wp-json/wp/v2/posts?search=$query endpoint
  ///
  ///Throws a [ServerException] for all errors codes.
  Future<List<ArticleModel>> searchArticles({String? query});

  ///Calls the https://news.libraria.com.br/wp-json/wp/v2/categories?per_page=50 endpoint
  ///
  ///Throws a [ServerException] for all errors codes.
  Future<List<Category>> getCategory({String url});

  ///Calls the news url when user press the specific article
  ///
  ///Throws a [ServerException] for all errors codes.
  Future<String> getSingleArticle({String url});
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  static final String baseURL = 'https://news.libraria.com.br/wp-json/wp/v2/';

  //Lista Principal de Artigos
  static final String articlesListEndpoint = '$baseURL' 'posts?page=';

  //Pesquisa de Artigos
  static final String search = '$baseURL' 'posts?search=';

  //Categories
  static final String categoriesArticles = '$baseURL' 'categories?per_page=50';
  final http.Client client;

  ArticleRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ArticleModel>> getListArticles({int page = 1}) async {
    final response = await client.get(Uri.parse('$articlesListEndpoint' '$page'));
    if (response.statusCode == 200) {
      return parseArticles(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ArticleModel>> searchArticles({String? query}) async {
    final response = await client.get(Uri.parse('$search' '$query'));
    if (response.statusCode == 200) {
      return parseArticles(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Category>> getCategory({String url = ''}) async {
    final response = await client.get(Uri.parse('$categoriesArticles'));
    if (response.statusCode == 200) {
      return parseCategory(response.body);
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

  List<CategoryModel> parseCategory(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<CategoryModel>((json) => CategoryModel.fromJson(json)).toList();
  }
}
