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

abstract class Field implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Field._({
    this.id,
    required this.subtopicId,
    required this.name,
    required this.type,
    required this.position,
    required this.createdAt,
  });

  factory Field({
    int? id,
    required int subtopicId,
    required String name,
    required String type,
    required int position,
    required DateTime createdAt,
  }) = _FieldImpl;

  factory Field.fromJson(Map<String, dynamic> jsonSerialization) {
    return Field(
      id: jsonSerialization['id'] as int?,
      subtopicId: jsonSerialization['subtopicId'] as int,
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as String,
      position: jsonSerialization['position'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = FieldTable();

  static const db = FieldRepository._();

  @override
  int? id;

  int subtopicId;

  String name;

  String type;

  int position;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Field]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Field copyWith({
    int? id,
    int? subtopicId,
    String? name,
    String? type,
    int? position,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Field',
      if (id != null) 'id': id,
      'subtopicId': subtopicId,
      'name': name,
      'type': type,
      'position': position,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Field',
      if (id != null) 'id': id,
      'subtopicId': subtopicId,
      'name': name,
      'type': type,
      'position': position,
      'createdAt': createdAt.toJson(),
    };
  }

  static FieldInclude include() {
    return FieldInclude._();
  }

  static FieldIncludeList includeList({
    _i1.WhereExpressionBuilder<FieldTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FieldTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FieldTable>? orderByList,
    FieldInclude? include,
  }) {
    return FieldIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Field.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Field.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FieldImpl extends Field {
  _FieldImpl({
    int? id,
    required int subtopicId,
    required String name,
    required String type,
    required int position,
    required DateTime createdAt,
  }) : super._(
         id: id,
         subtopicId: subtopicId,
         name: name,
         type: type,
         position: position,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Field]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Field copyWith({
    Object? id = _Undefined,
    int? subtopicId,
    String? name,
    String? type,
    int? position,
    DateTime? createdAt,
  }) {
    return Field(
      id: id is int? ? id : this.id,
      subtopicId: subtopicId ?? this.subtopicId,
      name: name ?? this.name,
      type: type ?? this.type,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class FieldUpdateTable extends _i1.UpdateTable<FieldTable> {
  FieldUpdateTable(super.table);

  _i1.ColumnValue<int, int> subtopicId(int value) => _i1.ColumnValue(
    table.subtopicId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> type(String value) => _i1.ColumnValue(
    table.type,
    value,
  );

  _i1.ColumnValue<int, int> position(int value) => _i1.ColumnValue(
    table.position,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class FieldTable extends _i1.Table<int?> {
  FieldTable({super.tableRelation}) : super(tableName: 'field') {
    updateTable = FieldUpdateTable(this);
    subtopicId = _i1.ColumnInt(
      'subtopicId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    type = _i1.ColumnString(
      'type',
      this,
    );
    position = _i1.ColumnInt(
      'position',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final FieldUpdateTable updateTable;

  late final _i1.ColumnInt subtopicId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString type;

  late final _i1.ColumnInt position;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    subtopicId,
    name,
    type,
    position,
    createdAt,
  ];
}

class FieldInclude extends _i1.IncludeObject {
  FieldInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Field.t;
}

class FieldIncludeList extends _i1.IncludeList {
  FieldIncludeList._({
    _i1.WhereExpressionBuilder<FieldTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Field.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Field.t;
}

class FieldRepository {
  const FieldRepository._();

  /// Returns a list of [Field]s matching the given query parameters.
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
  Future<List<Field>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FieldTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FieldTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FieldTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Field>(
      where: where?.call(Field.t),
      orderBy: orderBy?.call(Field.t),
      orderByList: orderByList?.call(Field.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Field] matching the given query parameters.
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
  Future<Field?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FieldTable>? where,
    int? offset,
    _i1.OrderByBuilder<FieldTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FieldTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Field>(
      where: where?.call(Field.t),
      orderBy: orderBy?.call(Field.t),
      orderByList: orderByList?.call(Field.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Field] by its [id] or null if no such row exists.
  Future<Field?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Field>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Field]s in the list and returns the inserted rows.
  ///
  /// The returned [Field]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Field>> insert(
    _i1.DatabaseSession session,
    List<Field> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Field>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Field] and returns the inserted row.
  ///
  /// The returned [Field] will have its `id` field set.
  Future<Field> insertRow(
    _i1.DatabaseSession session,
    Field row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Field>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Field]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Field>> update(
    _i1.DatabaseSession session,
    List<Field> rows, {
    _i1.ColumnSelections<FieldTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Field>(
      rows,
      columns: columns?.call(Field.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Field]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Field> updateRow(
    _i1.DatabaseSession session,
    Field row, {
    _i1.ColumnSelections<FieldTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Field>(
      row,
      columns: columns?.call(Field.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Field] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Field?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<FieldUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Field>(
      id,
      columnValues: columnValues(Field.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Field]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Field>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<FieldUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FieldTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FieldTable>? orderBy,
    _i1.OrderByListBuilder<FieldTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Field>(
      columnValues: columnValues(Field.t.updateTable),
      where: where(Field.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Field.t),
      orderByList: orderByList?.call(Field.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Field]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Field>> delete(
    _i1.DatabaseSession session,
    List<Field> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Field>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Field].
  Future<Field> deleteRow(
    _i1.DatabaseSession session,
    Field row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Field>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Field>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FieldTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Field>(
      where: where(Field.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FieldTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Field>(
      where: where?.call(Field.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Field] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FieldTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Field>(
      where: where(Field.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
