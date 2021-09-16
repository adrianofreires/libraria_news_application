part of 'search_articles_bloc.dart';

abstract class SearchArticlesState extends Equatable {
  const SearchArticlesState();

  @override
  List<Object> get props => [];
}

class SearchArticlesInitial extends SearchArticlesState {}

class SearchLoading extends SearchArticlesState {}

class SearchResult extends SearchArticlesState {
  final List<Article> results;

  SearchResult({required this.results});

  @override
  List<Object> get props => [results];
}

class Error extends SearchArticlesState {
  final String error;

  Error({required this.error}) : super();
}
