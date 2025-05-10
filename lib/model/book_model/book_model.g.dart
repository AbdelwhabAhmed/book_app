// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
      id: json['id'] as String,
      name: json['name'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      fileUrl: json['fileURL'] as String?,
      categoryName: json['categoryName'] as String,
      publishedYear: (json['publishedYear'] as num).toInt(),
      averageRating: (json['averageRating'] as num).toDouble(),
      numPages: (json['numPages'] as num).toInt(),
      linkBook: json['linkBook'] as String?,
      isFavorite: json['isFavorite'] as bool,
    );

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'author': instance.author,
      'description': instance.description,
      'fileURL': instance.fileUrl,
      'categoryName': instance.categoryName,
      'publishedYear': instance.publishedYear,
      'averageRating': instance.averageRating,
      'numPages': instance.numPages,
      'linkBook': instance.linkBook,
      'isFavorite': instance.isFavorite,
    };
