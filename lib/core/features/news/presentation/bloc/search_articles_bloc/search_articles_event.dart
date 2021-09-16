part of 'search_articles_bloc.dart';

abstract class SearchArticlesEvent extends Equatable {
  const SearchArticlesEvent();

  @override
  List<Object> get props => [];
}

class SearchQueryEvent extends SearchArticlesEvent {
  final String query;
  SearchQueryEvent({required this.query}) : super();
}
