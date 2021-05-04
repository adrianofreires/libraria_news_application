import 'package:dartz/dartz.dart';
import 'package:libraria_news_application/core/error/failures.dart';
import 'package:libraria_news_application/core/features/news/domain/entities/article.dart';
import 'package:libraria_news_application/core/features/news/domain/repositories/article_repositories.dart';
import 'package:libraria_news_application/core/usecases/usecase.dart';

class GetArticles extends UseCase {
  final ArticleRepository repository;

  GetArticles(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(params) async {
    return await repository.getListArticles(page: params);
  }
}
