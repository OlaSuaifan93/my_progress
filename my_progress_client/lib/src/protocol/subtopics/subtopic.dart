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

abstract class Subtopic implements _i1.SerializableModel {
  Subtopic._({
    this.id,
    required this.topicId,
    required this.name,
    this.description,
    required this.createdAt,
  });

  factory Subtopic({
    int? id,
    required int topicId,
    required String name,
    String? description,
    required DateTime createdAt,
  }) = _SubtopicImpl;

  factory Subtopic.fromJson(Map<String, dynamic> jsonSerialization) {
    return Subtopic(
      id: jsonSerialization['id'] as int?,
      topicId: jsonSerialization['topicId'] as int,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int topicId;

  String name;

  String? description;

  DateTime createdAt;

  /// Returns a shallow copy of this [Subtopic]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Subtopic copyWith({
    int? id,
    int? topicId,
    String? name,
    String? description,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Subtopic',
      if (id != null) 'id': id,
      'topicId': topicId,
      'name': name,
      if (description != null) 'description': description,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubtopicImpl extends Subtopic {
  _SubtopicImpl({
    int? id,
    required int topicId,
    required String name,
    String? description,
    required DateTime createdAt,
  }) : super._(
         id: id,
         topicId: topicId,
         name: name,
         description: description,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Subtopic]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Subtopic copyWith({
    Object? id = _Undefined,
    int? topicId,
    String? name,
    Object? description = _Undefined,
    DateTime? createdAt,
  }) {
    return Subtopic(
      id: id is int? ? id : this.id,
      topicId: topicId ?? this.topicId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
