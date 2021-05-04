import 'package:dartz/dartz.dart';
import 'package:libraria_news_application/core/error/exception.dart';
import 'package:libraria_news_application/core/error/failures.dart';
import 'package:libraria_news_application/core/features/news/data/datasources/local/article_local_datasource.dart';
import 'package:libraria_news_application/core/features/news/data/datasources/remote/article_remote_datasource.dart';
import 'package:libraria_news_application/core/features/news/domain/entities/article.dart';
import 'package:libraria_news_application/core/features/news/domain/repositories/article_repositories.dart';
import 'package:libraria_news_application/core/network/network_info.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;
  final ArticleLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ArticleRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, List<Article>>> getListArticles({int page = 1}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteArticles = await remoteDataSource.getListArticles(page: page);
        localDataSource.cacheArticles(remoteArticles);
        return Right(remoteArticles);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localArticles = await localDataSource.getLastArticles();
        return Right(localArticles);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, String>> getSingleArticle({String url = ''}) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.getSingleArticle(url: url));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
