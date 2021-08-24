// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticleModelHiveAdapter extends TypeAdapter<ArticleModelHive> {
  @override
  final int typeId = 0;

  @override
  ArticleModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticleModelHive(
      id: fields[0] as int,
      date: fields[1],
      image: fields[2] as String,
      title: fields[3] as String,
      linkUrl: fields[4] as String,
      categoryUrl: fields[5] as String,
      categories: fields[6] as List,
    );
  }

  @override
  void write(BinaryWriter writer, ArticleModelHive obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleModelHiveAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
