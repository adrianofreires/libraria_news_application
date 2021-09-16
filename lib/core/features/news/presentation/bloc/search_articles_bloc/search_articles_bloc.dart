import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:libraria_news_application/core/error/failures.dart';
import 'package:libraria_news_application/core/features/news/domain/entities/article.dart';
import 'package:libraria_news_application/core/features/news/domain/usecases/search_articles.dart';

part 'search_articles_event.dart';
part 'search_articles_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Falha no Servidor';
const String CACHE_FAILURE_MESSAGE = 'Falha no Cache';

class SearchArticlesBloc extends Bloc<SearchArticlesEvent, SearchArticlesState> {
  final SearchArticles searchArticles;

  SearchArticlesBloc({required this.searchArticles}) : super(SearchArticlesInitial());

  @override
  Stream<SearchArticlesState> mapEventToState(
    SearchArticlesEvent event,
  ) async* {
    if (event is SearchQueryEvent) {
      final failureOrArticle = await searchArticles.call(event.query);
      yield failureOrArticle.fold((failure) => Error(error: _mapFailureToMessage(failure)), (articles) {
        return SearchResult(results: articles);
      });
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
