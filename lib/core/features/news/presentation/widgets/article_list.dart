import 'package:flutter/material.dart';
import 'package:libraria_news_application/core/features/news/domain/entities/article.dart';
import 'package:libraria_news_application/core/features/news/presentation/pages/single_article_page.dart';

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
            margin: EdgeInsets.symmetric(vertical: 9.0, horizontal: 8.0),
            color: Color(0xFF1e1e22),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return SingleArticle(
                        url: articles[index].linkUrl,
                        category: articles[index].categories.first,
                      );
                    });
              },
              child: Column(
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(8.0), child: Image.network(articles[index].image)),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          articles[index].categories.first,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: ThemeData.dark().errorColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          articles[index].dateFormatted(articles[index].date)!,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          articles[index].title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
