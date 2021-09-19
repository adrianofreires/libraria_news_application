import 'package:dartz/dartz.dart';
import 'package:libraria_news_application/core/error/failures.dart';
import 'package:libraria_news_application/core/features/news/domain/entities/article.dart';
import 'package:libraria_news_application/core/features/news/domain/entities/category.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<Article>>> getListArticles({int page});
  Future<Either<Failure, List<Article>>> searchArticles({String query});
  Future<Either<Failure, String>> getSingleArticle({String url});
  Future<Either<Failure, List<Category>>> getCategories({String url});
}
