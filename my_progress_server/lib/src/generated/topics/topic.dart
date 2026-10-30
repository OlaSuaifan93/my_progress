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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Topic implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = TopicTable();

  static const db = TopicRepository._();

  @override
  int? id;

  String name;

  String? description;

  DateTime createdAt;

  String? ownerUserIdentifier;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static TopicInclude include() {
    return TopicInclude._();
  }

  static TopicIncludeList includeList({
    _i1.WhereExpressionBuilder<TopicTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TopicTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TopicTable>? orderByList,
    TopicInclude? include,
  }) {
    return TopicIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Topic.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Topic.t),
      include: include,
    );
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

class TopicUpdateTable extends _i1.UpdateTable<TopicTable> {
  TopicUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<String, String> ownerUserIdentifier(String? value) =>
      _i1.ColumnValue(
        table.ownerUserIdentifier,
        value,
      );
}

class TopicTable extends _i1.Table<int?> {
  TopicTable({super.tableRelation}) : super(tableName: 'topic') {
    updateTable = TopicUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    ownerUserIdentifier = _i1.ColumnString(
      'ownerUserIdentifier',
      this,
    );
  }

  late final TopicUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString ownerUserIdentifier;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    description,
    createdAt,
    ownerUserIdentifier,
  ];
}

class TopicInclude extends _i1.IncludeObject {
  TopicInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Topic.t;
}

class TopicIncludeList extends _i1.IncludeList {
  TopicIncludeList._({
    _i1.WhereExpressionBuilder<TopicTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Topic.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Topic.t;
}

class TopicRepository {
  const TopicRepository._();

  /// Returns a list of [Topic]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Topic>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TopicTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TopicTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TopicTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Topic>(
      where: where?.call(Topic.t),
      orderBy: orderBy?.call(Topic.t),
      orderByList: orderByList?.call(Topic.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Topic] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Topic?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TopicTable>? where,
    int? offset,
    _i1.OrderByBuilder<TopicTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TopicTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Topic>(
      where: where?.call(Topic.t),
      orderBy: orderBy?.call(Topic.t),
      orderByList: orderByList?.call(Topic.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Topic] by its [id] or null if no such row exists.
  Future<Topic?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Topic>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Topic]s in the list and returns the inserted rows.
  ///
  /// The returned [Topic]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Topic>> insert(
    _i1.DatabaseSession session,
    List<Topic> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Topic>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Topic] and returns the inserted row.
  ///
  /// The returned [Topic] will have its `id` field set.
  Future<Topic> insertRow(
    _i1.DatabaseSession session,
    Topic row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Topic>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Topic]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Topic>> update(
    _i1.DatabaseSession session,
    List<Topic> rows, {
    _i1.ColumnSelections<TopicTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Topic>(
      rows,
      columns: columns?.call(Topic.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Topic]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Topic> updateRow(
    _i1.DatabaseSession session,
    Topic row, {
    _i1.ColumnSelections<TopicTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Topic>(
      row,
      columns: columns?.call(Topic.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Topic] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Topic?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<TopicUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Topic>(
      id,
      columnValues: columnValues(Topic.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Topic]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Topic>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TopicUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TopicTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TopicTable>? orderBy,
    _i1.OrderByListBuilder<TopicTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Topic>(
      columnValues: columnValues(Topic.t.updateTable),
      where: where(Topic.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Topic.t),
      orderByList: orderByList?.call(Topic.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Topic]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Topic>> delete(
    _i1.DatabaseSession session,
    List<Topic> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Topic>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Topic].
  Future<Topic> deleteRow(
    _i1.DatabaseSession session,
    Topic row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Topic>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Topic>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TopicTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Topic>(
      where: where(Topic.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TopicTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Topic>(
      where: where?.call(Topic.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Topic] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TopicTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Topic>(
      where: where(Topic.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
