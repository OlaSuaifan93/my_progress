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

abstract class Subtopic
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = SubtopicTable();

  static const db = SubtopicRepository._();

  @override
  int? id;

  int topicId;

  String name;

  String? description;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Subtopic',
      if (id != null) 'id': id,
      'topicId': topicId,
      'name': name,
      if (description != null) 'description': description,
      'createdAt': createdAt.toJson(),
    };
  }

  static SubtopicInclude include() {
    return SubtopicInclude._();
  }

  static SubtopicIncludeList includeList({
    _i1.WhereExpressionBuilder<SubtopicTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtopicTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtopicTable>? orderByList,
    SubtopicInclude? include,
  }) {
    return SubtopicIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Subtopic.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Subtopic.t),
      include: include,
    );
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

class SubtopicUpdateTable extends _i1.UpdateTable<SubtopicTable> {
  SubtopicUpdateTable(super.table);

  _i1.ColumnValue<int, int> topicId(int value) => _i1.ColumnValue(
    table.topicId,
    value,
  );

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
}

class SubtopicTable extends _i1.Table<int?> {
  SubtopicTable({super.tableRelation}) : super(tableName: 'subtopic') {
    updateTable = SubtopicUpdateTable(this);
    topicId = _i1.ColumnInt(
      'topicId',
      this,
    );
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
  }

  late final SubtopicUpdateTable updateTable;

  late final _i1.ColumnInt topicId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    topicId,
    name,
    description,
    createdAt,
  ];
}

class SubtopicInclude extends _i1.IncludeObject {
  SubtopicInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Subtopic.t;
}

class SubtopicIncludeList extends _i1.IncludeList {
  SubtopicIncludeList._({
    _i1.WhereExpressionBuilder<SubtopicTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Subtopic.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Subtopic.t;
}

class SubtopicRepository {
  const SubtopicRepository._();

  /// Returns a list of [Subtopic]s matching the given query parameters.
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
  Future<List<Subtopic>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtopicTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtopicTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtopicTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Subtopic>(
      where: where?.call(Subtopic.t),
      orderBy: orderBy?.call(Subtopic.t),
      orderByList: orderByList?.call(Subtopic.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Subtopic] matching the given query parameters.
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
  Future<Subtopic?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtopicTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubtopicTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtopicTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Subtopic>(
      where: where?.call(Subtopic.t),
      orderBy: orderBy?.call(Subtopic.t),
      orderByList: orderByList?.call(Subtopic.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Subtopic] by its [id] or null if no such row exists.
  Future<Subtopic?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Subtopic>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Subtopic]s in the list and returns the inserted rows.
  ///
  /// The returned [Subtopic]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Subtopic>> insert(
    _i1.DatabaseSession session,
    List<Subtopic> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Subtopic>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Subtopic] and returns the inserted row.
  ///
  /// The returned [Subtopic] will have its `id` field set.
  Future<Subtopic> insertRow(
    _i1.DatabaseSession session,
    Subtopic row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Subtopic>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Subtopic]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Subtopic>> update(
    _i1.DatabaseSession session,
    List<Subtopic> rows, {
    _i1.ColumnSelections<SubtopicTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Subtopic>(
      rows,
      columns: columns?.call(Subtopic.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Subtopic]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Subtopic> updateRow(
    _i1.DatabaseSession session,
    Subtopic row, {
    _i1.ColumnSelections<SubtopicTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Subtopic>(
      row,
      columns: columns?.call(Subtopic.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Subtopic] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Subtopic?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SubtopicUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Subtopic>(
      id,
      columnValues: columnValues(Subtopic.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Subtopic]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Subtopic>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SubtopicUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SubtopicTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtopicTable>? orderBy,
    _i1.OrderByListBuilder<SubtopicTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Subtopic>(
      columnValues: columnValues(Subtopic.t.updateTable),
      where: where(Subtopic.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Subtopic.t),
      orderByList: orderByList?.call(Subtopic.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Subtopic]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Subtopic>> delete(
    _i1.DatabaseSession session,
    List<Subtopic> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Subtopic>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Subtopic].
  Future<Subtopic> deleteRow(
    _i1.DatabaseSession session,
    Subtopic row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Subtopic>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Subtopic>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtopicTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Subtopic>(
      where: where(Subtopic.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtopicTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Subtopic>(
      where: where?.call(Subtopic.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Subtopic] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtopicTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Subtopic>(
      where: where(Subtopic.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
