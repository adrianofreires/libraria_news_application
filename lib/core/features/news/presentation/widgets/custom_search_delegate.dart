import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libraria_news_application/core/features/news/domain/entities/article.dart';
import 'package:libraria_news_application/core/features/news/presentation/bloc/search_articles_bloc/search_articles_bloc.dart';
import 'package:libraria_news_application/core/features/news/presentation/widgets/search_result_widget.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchArticlesBloc searchBloc;
  CustomSearchDelegate({required this.searchBloc})
      : super(
          searchFieldLabel: 'Procurar',
        );
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    searchBloc.add(SearchQueryEvent(query: query));
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'A busca precisa ter mais do que duas letras',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
        ],
      );
    }
    return SearchResultWidget();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<List<Article>>(builder: (context, AsyncSnapshot<List<Article>> snapshot) {
      if (!snapshot.hasData) {
        return Center(
          child: Text(
            'Nada Encontrado!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        );
      }
      final result = snapshot.data!.where((a) => a.title.toLowerCase().contains(query));
      return ListView(
        children: result
            .map<ListTile>((e) => ListTile(
                  onTap: () {},
                  leading: Image.network(e.image),
                  title: Text(e.title),
                  subtitle: Text(e.categories.first),
                ))
            .toList(),
      );
    });
  }
}
