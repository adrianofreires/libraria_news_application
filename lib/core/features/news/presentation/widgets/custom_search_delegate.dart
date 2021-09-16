import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libraria_news_application/core/features/news/domain/entities/article.dart';
import 'package:libraria_news_application/core/features/news/presentation/bloc/search_articles_bloc/search_articles_bloc.dart';
import 'package:libraria_news_application/core/features/news/presentation/pages/single_article_page.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchArticlesBloc searchBloc;
  CustomSearchDelegate({required this.searchBloc})
      : super(searchFieldLabel: 'Procurar', searchFieldStyle: TextStyle(color: Colors.white));
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
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      );
    }
    return Container(
      child: BlocBuilder<SearchArticlesBloc, SearchArticlesState>(builder: (context, state) {
        if (state is SearchArticlesInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchResult) {
          if (state.results.isEmpty) {
            return Center(
              child: Text(
                'Nenhum resultado encontrado!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: state.results.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(state.results[index].image),
                    title: Text(
                      state.results[index].title,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      state.results[index].categories.first,
                      style: TextStyle(color: Color(0xFFe82822), fontWeight: FontWeight.w700),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return SingleArticle(
                              url: state.results[index].linkUrl,
                              category: state.results[index].categories.first,
                            );
                          });
                    },
                  );
                });
          }
        } else {
          return Text(
            'Erro ao carregar a pesquisa!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          );
        }
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<List<Article>>(builder: (context, AsyncSnapshot<List<Article>> snapshot) {
      if (!snapshot.hasData) {
        return Center(
          child: Text(
            'Nada Encontrado!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
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
