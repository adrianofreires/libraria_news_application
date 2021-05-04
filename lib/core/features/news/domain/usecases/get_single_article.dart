import 'package:dartz/dartz.dart';
import 'package:libraria_news_application/core/error/failures.dart';
import 'package:libraria_news_application/core/features/news/domain/repositories/article_repositories.dart';
import 'package:libraria_news_application/core/usecases/usecase.dart';

class GetSingleArticle extends UseCase {
  final ArticleRepository repository;

  GetSingleArticle(this.repository);

  @override
  Future<Either<Failure, String>> call(params) async {
    var url = cast<String>(params);
    return await repository.getSingleArticle(url: url);
  }
}
