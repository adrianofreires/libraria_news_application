import 'package:libraria_news_application/core/features/news/domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({required int id, required String categoryName, required String categoryURL})
      : super(id: id, nameCategory: categoryName, categoryURL: categoryURL);
  factory CategoryModel.fromJson(Map<dynamic, dynamic> json) {
    return CategoryModel(
        id: json['id'], categoryName: json['name'], categoryURL: json['_links']['wp:post_type'][0]['href']);
  }
}
