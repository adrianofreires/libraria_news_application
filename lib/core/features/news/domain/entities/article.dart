import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final int id;
  final String date;
  final String image;
  final String title;
  final String linkUrl;
  final String categoryUrl;
  final List categories;

  Article(
      {required this.id,
      required this.date,
      required this.image,
      required this.title,
      required this.linkUrl,
      required this.categoryUrl,
      required this.categories});

  @override
  List<Object?> get props => [id, date, image, title, linkUrl, categoryUrl, categories];
}
