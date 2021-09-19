import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String nameCategory;
  final String categoryURL;

  Category({required this.id, required this.nameCategory, required this.categoryURL});

  @override
  List<Object?> get props => [id, nameCategory, categoryURL];
}
