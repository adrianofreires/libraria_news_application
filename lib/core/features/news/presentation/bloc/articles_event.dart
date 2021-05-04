part of 'articles_bloc.dart';

abstract class ArticlesEvent extends Equatable {
  const ArticlesEvent();

  @override
  List<Object> get props => [];
}

class ListArticles extends ArticlesEvent {
  ListArticles() : super();
}

class SingleArticle extends ArticlesEvent {
  final String url;

  SingleArticle(this.url) : super();
}
