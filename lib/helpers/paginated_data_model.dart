import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginated_data_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginatedData<T> extends Equatable {
  final List<T> data;
  final int totalCount;
  final int pageNumber;
  final int pageSize;
  final int totalPages;

  const PaginatedData({
    required this.data,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
  });

  bool get hasNextPage => pageNumber < totalPages;

  factory PaginatedData.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT, {
    String listKey = 'data',
  }) {
    final list = (json[listKey] as List<dynamic>?) ?? [];
    return PaginatedData<T>(
      data: list.map(fromJsonT).toList(),
      totalCount: json['totalCount'] as int,
      pageNumber: json['pageNumber'] as int,
      pageSize: json['pageSize'] as int,
      totalPages: json['totalPages'] as int,
    );
  }

  @override
  List<Object?> get props => [
        data,
        totalCount,
        pageNumber,
        pageSize,
        totalPages,
      ];
}
