import 'package:intl/intl.dart';
import 'package:libraria_news_application/core/features/news/domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel({
    required int id,
    required DateTime date,
    required String image,
    required String title,
    required String linkUrl,
    required String categoryUrl,
    required List categories,
  }) : super(
            id: id,
            date: date,
            image: image,
            title: title,
            linkUrl: linkUrl,
            categoryUrl: categoryUrl,
            categories: categories);
  factory ArticleModel.fromJson(Map<dynamic, dynamic> json) {
    return ArticleModel(
        id: json['id'],
        date: DateTime.parse(json['date']),
        image: json['fimg_url'],
        title: json['title']['rendered'],
        linkUrl: json['link'],
        categoryUrl: json['_links']['wp:term'][0]['href'],
        categories: json['categories_names']);
  }
}
