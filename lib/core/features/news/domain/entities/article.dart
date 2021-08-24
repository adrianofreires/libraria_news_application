import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Article extends Equatable {
  final int id;
  final DateTime date;
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

  String? dateFormatted(DateTime dateTime) {
    Duration duration = DateTime.now().difference(dateTime);
    if (duration.inDays > 1) {
      return DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_BR').format(dateTime);
    } else if (duration.inHours > 1) {
      return '${duration.inHours} horas atrás';
    } else if (duration.inHours == 1) {
      return '1 hora atrás';
    } else if (duration.inHours < 1) {
      return '${duration.inMinutes} minutos atrás';
    }
  }

  @override
  List<Object?> get props => [id, date, image, title, linkUrl, categoryUrl, categories];
}
