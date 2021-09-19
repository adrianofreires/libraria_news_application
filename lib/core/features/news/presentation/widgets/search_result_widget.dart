import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libraria_news_application/core/features/news/presentation/bloc/search_articles_bloc/search_articles_bloc.dart';
import 'package:libraria_news_application/core/features/news/presentation/pages/single_article_page.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<SearchArticlesBloc, SearchArticlesState>(builder: (context, state) {
        if (state is SearchArticlesInitial) {
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xFFe82822),
            ),
          );
        } else if (state is SearchResult) {
          if (state.results.isEmpty) {
            return Center(
              child: Text(
                'Nenhum resultado encontrado!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
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
                      style: TextStyle(color: Color(0xFFe82822), fontWeight: FontWeight.bold),
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
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          );
        }
      }),
    );
  }
}
