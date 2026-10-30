/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class DailyLog implements _i1.SerializableModel {
  DailyLog._({
    this.id,
    required this.subtopicId,
    required this.date,
    required this.createdAt,
  });

  factory DailyLog({
    int? id,
    required int subtopicId,
    required DateTime date,
    required DateTime createdAt,
  }) = _DailyLogImpl;

  factory DailyLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return DailyLog(
      id: jsonSerialization['id'] as int?,
      subtopicId: jsonSerialization['subtopicId'] as int,
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int subtopicId;

  DateTime date;

  DateTime createdAt;

  /// Returns a shallow copy of this [DailyLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DailyLog copyWith({
    int? id,
    int? subtopicId,
    DateTime? date,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DailyLog',
      if (id != null) 'id': id,
      'subtopicId': subtopicId,
      'date': date.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DailyLogImpl extends DailyLog {
  _DailyLogImpl({
    int? id,
    required int subtopicId,
    required DateTime date,
    required DateTime createdAt,
  }) : super._(
         id: id,
         subtopicId: subtopicId,
         date: date,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [DailyLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DailyLog copyWith({
    Object? id = _Undefined,
    int? subtopicId,
    DateTime? date,
    DateTime? createdAt,
  }) {
    return DailyLog(
      id: id is int? ? id : this.id,
      subtopicId: subtopicId ?? this.subtopicId,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
