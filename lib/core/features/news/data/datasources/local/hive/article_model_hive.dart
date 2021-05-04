import 'package:hive/hive.dart';
import 'package:libraria_news_application/core/features/news/data/models/article_model.dart';

part 'article_model_hive.g.dart';

@HiveType(typeId: 0)
class ArticleModelHive extends ArticleModel {
  ArticleModelHive({
    @HiveField(0) required int id,
    @HiveField(1) required String date,
    @HiveField(2) required String image,
    @HiveField(3) required String title,
    @HiveField(4) required String linkUrl,
    @HiveField(5) required String categoryUrl,
    @HiveField(6) required List categories,
  }) : super(
            id: id,
            date: date,
            image: image,
            title: title,
            linkUrl: linkUrl,
            categoryUrl: categoryUrl,
            categories: categories);
}
