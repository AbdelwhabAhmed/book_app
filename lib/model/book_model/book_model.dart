import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

@JsonSerializable()
class BookModel extends Equatable {
  final String id;
  final String name;
  final String author;
  final String description;
  @JsonKey(name: 'fileURL')
  final String? fileUrl;
  final String categoryName;
  final int publishedYear;
  final double averageRating;
  final int numPages;
  final String? linkBook;
  bool isFavorite;
  BookModel({
    required this.id,
    required this.name,
    required this.author,
    required this.description,
    required this.fileUrl,
    required this.categoryName,
    required this.publishedYear,
    required this.averageRating,
    required this.numPages,
    required this.linkBook,
    required this.isFavorite,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        author,
        description,
        fileUrl,
        categoryName,
        publishedYear,
        averageRating,
        numPages,
        linkBook
      ];
}
