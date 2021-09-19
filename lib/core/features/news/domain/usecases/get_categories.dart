import 'package:dartz/dartz.dart';
import 'package:libraria_news_application/core/error/failures.dart';
import 'package:libraria_news_application/core/features/news/domain/entities/category.dart';
import 'package:libraria_news_application/core/features/news/domain/repositories/article_repositories.dart';
import 'package:libraria_news_application/core/usecases/usecase.dart';

class GetCategories extends UseCase {
  final ArticleRepository repository;

  GetCategories(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(params) async {
    var url = cast<String>(params);
    return await repository.getCategories(url: url);
  }
}
