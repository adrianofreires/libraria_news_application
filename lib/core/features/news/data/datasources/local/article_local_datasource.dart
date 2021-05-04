import 'package:libraria_news_application/core/features/news/data/models/article_model.dart';

abstract class ArticleLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<List<ArticleModel>> getLastArticles();

  Future<bool> initLocalDataBase();

  Future<void> deleteLocalDataBase();

  Future<void> deleteAllArticles();

  Future<void> cacheArticles(List<ArticleModel> articlesToCache);
}
