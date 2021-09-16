import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libraria_news_application/core/features/news/domain/entities/article.dart';
import 'package:libraria_news_application/core/features/news/presentation/bloc/articles_bloc/articles_bloc.dart';
import 'package:libraria_news_application/core/features/news/presentation/bloc/search_articles_bloc/search_articles_bloc.dart';
import 'package:libraria_news_application/core/features/news/presentation/widgets/article_list.dart';
import 'package:libraria_news_application/core/features/news/presentation/widgets/article_loading.dart';
import 'package:libraria_news_application/core/features/news/presentation/widgets/custom_search_delegate.dart';

class NewsHomePage extends StatefulWidget {
  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  ScrollController _scrollController = ScrollController();
  List<Article> allArticles = [];

  @override
  void initState() {
    BlocProvider.of<ArticlesBloc>(context).add(ListArticles());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        print(_scrollController.position.pixels);
        BlocProvider.of<ArticlesBloc>(context).add(ListArticles());
      }
    });
    super.initState();
  }

  Widget buildBody(BuildContext context) {
    return Container(
      child: BlocListener<ArticlesBloc, ArticlesState>(
        listener: (context, state) {
          if (state is ListArticlesLoaded) {
            allArticles.addAll(state.listArticle);
          }
        },
        child: BlocBuilder<ArticlesBloc, ArticlesState>(builder: (context, state) {
          if (state is ArticlesInitial) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xffe82822),
              ),
            );
          } else if (state is ArticlesLoading) {
            return ArticleLoading();
          } else if (state is ListArticlesLoaded) {
            return RefreshIndicator(
                color: Color(0xffe82822),
                onRefresh: () async {
                  allArticles = [];
                  BlocProvider.of<ArticlesBloc>(context).add(ArticlesRefresh());
                },
                child: ArticleList(articles: allArticles, controller: _scrollController));
          } else {
            return Text('Erro');
          }
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Image(
          image: AssetImage('assets/logo_news_bar.png'),
          width: 120,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(searchBloc: BlocProvider.of<SearchArticlesBloc>(context)));
            },
          ),
        ],
      ),
      body: buildBody(context),
    );
  }
}
