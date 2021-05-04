import 'package:dartz/dartz.dart';
import 'package:libraria_news_application/core/error/failures.dart';
import 'package:libraria_news_application/core/features/news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<Article>>> getListArticles({int page});
  Future<Either<Failure, String>> getSingleArticle({String url});
}
