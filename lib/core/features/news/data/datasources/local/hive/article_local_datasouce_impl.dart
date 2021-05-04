import 'package:hive/hive.dart';

import 'package:flutter/foundation.dart' as foundation;
import 'package:libraria_news_application/core/features/news/data/datasources/local/hive/article_model_hive.dart';
import 'package:libraria_news_application/core/features/news/data/models/article_model.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../article_local_datasource.dart';

const String CACHE_ARTICLES = 'cachedArticles';

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  @override
  Future<void> cacheArticles(List<ArticleModel> articlesToCache) async {
    final articleBox = Hive.box<ArticleModel>(CACHE_ARTICLES);
    final deleted = await articleBox.clear();
    print('deleted $deleted entries from hive $CACHE_ARTICLES box');
    final converted = articlesToCache
        .map((e) => ArticleModelHive(
            id: e.id,
            date: e.date,
            image: e.image,
            title: e.title,
            linkUrl: e.linkUrl,
            categoryUrl: e.categoryUrl,
            categories: e.categories))
        .toList();
    final entries = await articleBox.addAll(converted);
    print(entries);
  }

  @override
  Future<List<ArticleModel>> getLastArticles() async {
    final listArticlesCached = Hive.box<ArticleModelHive>(CACHE_ARTICLES);
    return listArticlesCached.values
        .map<ArticleModelHive>((e) => ArticleModelHive(
            id: e.id,
            date: e.date,
            image: e.image,
            title: e.title,
            linkUrl: e.linkUrl,
            categoryUrl: e.categoryUrl,
            categories: e.categories))
        .toList();
  }

  @override
  Future<void> deleteAllArticles() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteLocalDataBase() {
    throw UnimplementedError();
  }

  @override
  Future<bool> initLocalDataBase() async {
    try {
      if (!foundation.kIsWeb) {
        final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
        Hive.init(appDocumentDir.path);
      }
      Hive.registerAdapter(ArticleModelHiveAdapter());
      await Hive.openBox<ArticleModelHive>(CACHE_ARTICLES);
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }
}
