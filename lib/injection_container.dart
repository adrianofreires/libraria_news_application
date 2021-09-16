import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:libraria_news_application/core/features/news/domain/usecases/search_articles.dart';
import 'package:libraria_news_application/core/features/news/presentation/bloc/search_articles_bloc/search_articles_bloc.dart';

import 'core/features/news/data/datasources/local/article_local_datasource.dart';
import 'core/features/news/data/datasources/local/hive/article_local_datasouce_impl.dart';
import 'core/features/news/data/datasources/remote/article_remote_datasource.dart';
import 'core/features/news/data/repositories/article_repository_impl.dart';
import 'core/features/news/domain/repositories/article_repositories.dart';
import 'core/features/news/domain/usecases/get_articles.dart';
import 'core/features/news/domain/usecases/get_single_article.dart';
import 'core/features/news/presentation/bloc/articles_bloc/articles_bloc.dart';
import 'core/network/network_info.dart';

final service_locator = GetIt.instance;

Future<void> init() async {
  //!Features - Articles

  //Bloc
  service_locator
      .registerFactory(() => ArticlesBloc(getListArticles: service_locator(), singleArticle: service_locator()));
  service_locator.registerFactory(() => SearchArticlesBloc(searchArticles: service_locator()));

  //Use Cases
  service_locator.registerLazySingleton(() => GetArticles(service_locator()));
  service_locator.registerLazySingleton(() => GetSingleArticle(service_locator()));
  service_locator.registerLazySingleton(() => SearchArticles(service_locator()));

  //Repository
  service_locator.registerLazySingleton<ArticleRepository>(() => ArticleRepositoryImpl(
      remoteDataSource: service_locator(), localDataSource: service_locator(), networkInfo: service_locator()));

  //DataSource
  service_locator
      .registerLazySingleton<ArticleRemoteDataSource>(() => ArticleRemoteDataSourceImpl(client: service_locator()));
  service_locator.registerLazySingleton<ArticleLocalDataSource>(() => ArticleLocalDataSourceImpl());

  //!Core
  service_locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(service_locator()));

  //!External
  final hive = ArticleLocalDataSourceImpl().initLocalDataBase();
  service_locator.registerLazySingleton(() => hive);
  service_locator.registerLazySingleton(() => http.Client());
  service_locator.registerLazySingleton(() => InternetConnectionChecker());
}
