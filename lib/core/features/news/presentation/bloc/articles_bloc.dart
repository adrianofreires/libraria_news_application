import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:libraria_news_application/core/error/failures.dart';
import 'package:libraria_news_application/core/features/news/domain/entities/article.dart';
import 'package:libraria_news_application/core/features/news/domain/usecases/get_articles.dart';
import 'package:libraria_news_application/core/features/news/domain/usecases/get_single_article.dart';

part 'articles_event.dart';

part 'articles_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Falha no Servidor';
const String CACHE_FAILURE_MESSAGE = 'Falha no Cache';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final GetArticles getListArticles;
  final GetSingleArticle singleArticle;
  List<Article> allArticles = [];
  int currentPage = 1;

  ArticlesBloc({
    required this.getListArticles,
    required this.singleArticle,
  }) : super(ArticlesInitial());

  @override
  Stream<ArticlesState> mapEventToState(
    ArticlesEvent event,
  ) async* {
    if (event is ListArticles) {
      final failureOrArticle = await getListArticles.call(currentPage);
      print('Pagina Atual: $currentPage');
      currentPage++;
      yield failureOrArticle.fold((failure) => Error(error: _mapFailureToMessage(failure)), (articles) {
        //final articlesRefresh = _articlesRefresh(articles);
        return ListArticlesLoaded(listArticle: articles);
      });
    } else if (event is ArticlesRefresh) {
      yield ArticlesRefreshing();
      final failureOrArticle = await getListArticles.call(1);
      print('Lista Nova: 1');
      yield failureOrArticle.fold((failure) => Error(error: _mapFailureToMessage(failure)), (articles) {
        //final articlesRefresh = _articlesRefresh(articles);
        return ListArticlesLoaded(listArticle: articles);
      });
    } else if (event is SingleArticle) {
      final url = event.url;
      yield ArticlesLoading();
      final failureOrArticle = await singleArticle.call(url);
      yield failureOrArticle.fold(
          (failure) => Error(error: _mapFailureToMessage(failure)), (url) => SingleArticleBloc(urlArticle: url));
    }
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Erro inesperado';
  }
}
