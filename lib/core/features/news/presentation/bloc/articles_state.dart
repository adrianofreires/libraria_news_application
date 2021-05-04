part of 'articles_bloc.dart';

abstract class ArticlesState extends Equatable {
  const ArticlesState();

  @override
  List<Object> get props => [];
}

class ArticlesInitial extends ArticlesState {}

class ArticlesLoading extends ArticlesState {}

class ListArticlesLoaded extends ArticlesState {
  final List<Article> listArticle;

  ListArticlesLoaded({required this.listArticle});

  @override
  List<Object> get props => [listArticle];
  @override
  String toString() => 'ListArticlesLoaded { listArticles: ${listArticle.length}';
}

class SingleArticleBloc extends ArticlesState {
  final String urlArticle;

  SingleArticleBloc({required this.urlArticle});

  @override
  List<Object> get props => [urlArticle];
}

class Error extends ArticlesState {
  final String error;

  Error({required this.error}) : super();
}
