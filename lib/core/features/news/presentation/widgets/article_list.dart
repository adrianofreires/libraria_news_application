import 'package:flutter/material.dart';
import 'package:libraria_news_application/core/features/news/domain/entities/article.dart';
import 'package:libraria_news_application/core/features/news/presentation/widgets/single_article_widget.dart';

class ArticleList extends StatelessWidget {
  final List<Article> articles;
  final ScrollController controller;

  const ArticleList({Key? key, required this.articles, required this.controller}) : super(key: key);
  @override
  Widget build(
    BuildContext context,
  ) {
    return ListView.builder(
        itemCount: articles.length,
        controller: controller,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 9.0, horizontal: 8.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            color: Colors.black,
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return SingleArticle(url: articles[index].linkUrl);
                    });
              },
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                      child: Image.network(articles[index].image)),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          articles[index].categories.first,
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        Text(
                          articles[index].date,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                    child: Text(
                      articles[index].title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
