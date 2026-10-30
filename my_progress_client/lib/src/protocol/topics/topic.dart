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

abstract class Topic implements _i1.SerializableModel {
  Topic._({
    this.id,
    required this.name,
    this.description,
    required this.createdAt,
    this.ownerUserIdentifier,
  });

  factory Topic({
    int? id,
    required String name,
    String? description,
    required DateTime createdAt,
    String? ownerUserIdentifier,
  }) = _TopicImpl;

  factory Topic.fromJson(Map<String, dynamic> jsonSerialization) {
    return Topic(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      ownerUserIdentifier: jsonSerialization['ownerUserIdentifier'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String? description;

  DateTime createdAt;

  String? ownerUserIdentifier;

  /// Returns a shallow copy of this [Topic]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Topic copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? createdAt,
    String? ownerUserIdentifier,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Topic',
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      'createdAt': createdAt.toJson(),
      if (ownerUserIdentifier != null)
        'ownerUserIdentifier': ownerUserIdentifier,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TopicImpl extends Topic {
  _TopicImpl({
    int? id,
    required String name,
    String? description,
    required DateTime createdAt,
    String? ownerUserIdentifier,
  }) : super._(
         id: id,
         name: name,
         description: description,
         createdAt: createdAt,
         ownerUserIdentifier: ownerUserIdentifier,
       );

  /// Returns a shallow copy of this [Topic]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Topic copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    DateTime? createdAt,
    Object? ownerUserIdentifier = _Undefined,
  }) {
    return Topic(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      createdAt: createdAt ?? this.createdAt,
      ownerUserIdentifier: ownerUserIdentifier is String?
          ? ownerUserIdentifier
          : this.ownerUserIdentifier,
    );
  }
}
