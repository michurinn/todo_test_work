// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TodoItemsTable extends TodoItems
    with TableInfo<$TodoItemsTable, TodoItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<DateTime> index = GeneratedColumn<DateTime>(
      'index', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title =
      GeneratedColumn<String>('title', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0xFFAABBCC));
  static const VerificationMeta _isFinishedMeta =
      const VerificationMeta('isFinished');
  @override
  late final GeneratedColumn<bool> isFinished = GeneratedColumn<bool>(
      'is_finished', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_finished" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, index, title, color, isFinished];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo_items';
  @override
  VerificationContext validateIntegrity(Insertable<TodoItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index']!, _indexMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('is_finished')) {
      context.handle(
          _isFinishedMeta,
          isFinished.isAcceptableOrUnknown(
              data['is_finished']!, _isFinishedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      index: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}index'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color'])!,
      isFinished: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_finished'])!,
    );
  }

  @override
  $TodoItemsTable createAlias(String alias) {
    return $TodoItemsTable(attachedDatabase, alias);
  }
}

class TodoItem extends DataClass implements Insertable<TodoItem> {
  final int id;
  final DateTime index;
  final String title;
  final int color;
  final bool isFinished;
  const TodoItem(
      {required this.id,
      required this.index,
      required this.title,
      required this.color,
      required this.isFinished});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['index'] = Variable<DateTime>(index);
    map['title'] = Variable<String>(title);
    map['color'] = Variable<int>(color);
    map['is_finished'] = Variable<bool>(isFinished);
    return map;
  }

  TodoItemsCompanion toCompanion(bool nullToAbsent) {
    return TodoItemsCompanion(
      id: Value(id),
      index: Value(index),
      title: Value(title),
      color: Value(color),
      isFinished: Value(isFinished),
    );
  }

  factory TodoItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoItem(
      id: serializer.fromJson<int>(json['id']),
      index: serializer.fromJson<DateTime>(json['index']),
      title: serializer.fromJson<String>(json['title']),
      color: serializer.fromJson<int>(json['color']),
      isFinished: serializer.fromJson<bool>(json['isFinished']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'index': serializer.toJson<DateTime>(index),
      'title': serializer.toJson<String>(title),
      'color': serializer.toJson<int>(color),
      'isFinished': serializer.toJson<bool>(isFinished),
    };
  }

  TodoItem copyWith(
          {int? id,
          DateTime? index,
          String? title,
          int? color,
          bool? isFinished}) =>
      TodoItem(
        id: id ?? this.id,
        index: index ?? this.index,
        title: title ?? this.title,
        color: color ?? this.color,
        isFinished: isFinished ?? this.isFinished,
      );
  @override
  String toString() {
    return (StringBuffer('TodoItem(')
          ..write('id: $id, ')
          ..write('index: $index, ')
          ..write('title: $title, ')
          ..write('color: $color, ')
          ..write('isFinished: $isFinished')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, index, title, color, isFinished);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoItem &&
          other.id == this.id &&
          other.index == this.index &&
          other.title == this.title &&
          other.color == this.color &&
          other.isFinished == this.isFinished);
}

class TodoItemsCompanion extends UpdateCompanion<TodoItem> {
  final Value<int> id;
  final Value<DateTime> index;
  final Value<String> title;
  final Value<int> color;
  final Value<bool> isFinished;
  const TodoItemsCompanion({
    this.id = const Value.absent(),
    this.index = const Value.absent(),
    this.title = const Value.absent(),
    this.color = const Value.absent(),
    this.isFinished = const Value.absent(),
  });
  TodoItemsCompanion.insert({
    this.id = const Value.absent(),
    this.index = const Value.absent(),
    required String title,
    this.color = const Value.absent(),
    this.isFinished = const Value.absent(),
  }) : title = Value(title);
  static Insertable<TodoItem> custom({
    Expression<int>? id,
    Expression<DateTime>? index,
    Expression<String>? title,
    Expression<int>? color,
    Expression<bool>? isFinished,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (index != null) 'index': index,
      if (title != null) 'title': title,
      if (color != null) 'color': color,
      if (isFinished != null) 'is_finished': isFinished,
    });
  }

  TodoItemsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? index,
      Value<String>? title,
      Value<int>? color,
      Value<bool>? isFinished}) {
    return TodoItemsCompanion(
      id: id ?? this.id,
      index: index ?? this.index,
      title: title ?? this.title,
      color: color ?? this.color,
      isFinished: isFinished ?? this.isFinished,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (index.present) {
      map['index'] = Variable<DateTime>(index.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (isFinished.present) {
      map['is_finished'] = Variable<bool>(isFinished.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoItemsCompanion(')
          ..write('id: $id, ')
          ..write('index: $index, ')
          ..write('title: $title, ')
          ..write('color: $color, ')
          ..write('isFinished: $isFinished')
          ..write(')'))
        .toString();
  }
}

class $OrdersItemsTable extends OrdersItems
    with TableInfo<$OrdersItemsTable, OrdersItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
      'item_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [itemId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders_items';
  @override
  VerificationContext validateIntegrity(Insertable<OrdersItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  OrdersItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrdersItem(
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}item_id'])!,
    );
  }

  @override
  $OrdersItemsTable createAlias(String alias) {
    return $OrdersItemsTable(attachedDatabase, alias);
  }
}

class OrdersItem extends DataClass implements Insertable<OrdersItem> {
  final int itemId;
  const OrdersItem({required this.itemId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_id'] = Variable<int>(itemId);
    return map;
  }

  OrdersItemsCompanion toCompanion(bool nullToAbsent) {
    return OrdersItemsCompanion(
      itemId: Value(itemId),
    );
  }

  factory OrdersItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrdersItem(
      itemId: serializer.fromJson<int>(json['itemId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemId': serializer.toJson<int>(itemId),
    };
  }

  OrdersItem copyWith({int? itemId}) => OrdersItem(
        itemId: itemId ?? this.itemId,
      );
  @override
  String toString() {
    return (StringBuffer('OrdersItem(')
          ..write('itemId: $itemId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => itemId.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrdersItem && other.itemId == this.itemId);
}

class OrdersItemsCompanion extends UpdateCompanion<OrdersItem> {
  final Value<int> itemId;
  final Value<int> rowid;
  const OrdersItemsCompanion({
    this.itemId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrdersItemsCompanion.insert({
    required int itemId,
    this.rowid = const Value.absent(),
  }) : itemId = Value(itemId);
  static Insertable<OrdersItem> custom({
    Expression<int>? itemId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (itemId != null) 'item_id': itemId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrdersItemsCompanion copyWith({Value<int>? itemId, Value<int>? rowid}) {
    return OrdersItemsCompanion(
      itemId: itemId ?? this.itemId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersItemsCompanion(')
          ..write('itemId: $itemId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $TodoItemsTable todoItems = $TodoItemsTable(this);
  late final $OrdersItemsTable ordersItems = $OrdersItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todoItems, ordersItems];
}

typedef $$TodoItemsTableInsertCompanionBuilder = TodoItemsCompanion Function({
  Value<int> id,
  Value<DateTime> index,
  required String title,
  Value<int> color,
  Value<bool> isFinished,
});
typedef $$TodoItemsTableUpdateCompanionBuilder = TodoItemsCompanion Function({
  Value<int> id,
  Value<DateTime> index,
  Value<String> title,
  Value<int> color,
  Value<bool> isFinished,
});

class $$TodoItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TodoItemsTable,
    TodoItem,
    $$TodoItemsTableFilterComposer,
    $$TodoItemsTableOrderingComposer,
    $$TodoItemsTableProcessedTableManager,
    $$TodoItemsTableInsertCompanionBuilder,
    $$TodoItemsTableUpdateCompanionBuilder> {
  $$TodoItemsTableTableManager(_$AppDatabase db, $TodoItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TodoItemsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TodoItemsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$TodoItemsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> index = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<int> color = const Value.absent(),
            Value<bool> isFinished = const Value.absent(),
          }) =>
              TodoItemsCompanion(
            id: id,
            index: index,
            title: title,
            color: color,
            isFinished: isFinished,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> index = const Value.absent(),
            required String title,
            Value<int> color = const Value.absent(),
            Value<bool> isFinished = const Value.absent(),
          }) =>
              TodoItemsCompanion.insert(
            id: id,
            index: index,
            title: title,
            color: color,
            isFinished: isFinished,
          ),
        ));
}

class $$TodoItemsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $TodoItemsTable,
    TodoItem,
    $$TodoItemsTableFilterComposer,
    $$TodoItemsTableOrderingComposer,
    $$TodoItemsTableProcessedTableManager,
    $$TodoItemsTableInsertCompanionBuilder,
    $$TodoItemsTableUpdateCompanionBuilder> {
  $$TodoItemsTableProcessedTableManager(super.$state);
}

class $$TodoItemsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TodoItemsTable> {
  $$TodoItemsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get index => $state.composableBuilder(
      column: $state.table.index,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get color => $state.composableBuilder(
      column: $state.table.color,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isFinished => $state.composableBuilder(
      column: $state.table.isFinished,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TodoItemsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TodoItemsTable> {
  $$TodoItemsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get index => $state.composableBuilder(
      column: $state.table.index,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get color => $state.composableBuilder(
      column: $state.table.color,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isFinished => $state.composableBuilder(
      column: $state.table.isFinished,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$OrdersItemsTableInsertCompanionBuilder = OrdersItemsCompanion
    Function({
  required int itemId,
  Value<int> rowid,
});
typedef $$OrdersItemsTableUpdateCompanionBuilder = OrdersItemsCompanion
    Function({
  Value<int> itemId,
  Value<int> rowid,
});

class $$OrdersItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrdersItemsTable,
    OrdersItem,
    $$OrdersItemsTableFilterComposer,
    $$OrdersItemsTableOrderingComposer,
    $$OrdersItemsTableProcessedTableManager,
    $$OrdersItemsTableInsertCompanionBuilder,
    $$OrdersItemsTableUpdateCompanionBuilder> {
  $$OrdersItemsTableTableManager(_$AppDatabase db, $OrdersItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$OrdersItemsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$OrdersItemsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$OrdersItemsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> itemId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrdersItemsCompanion(
            itemId: itemId,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required int itemId,
            Value<int> rowid = const Value.absent(),
          }) =>
              OrdersItemsCompanion.insert(
            itemId: itemId,
            rowid: rowid,
          ),
        ));
}

class $$OrdersItemsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $OrdersItemsTable,
    OrdersItem,
    $$OrdersItemsTableFilterComposer,
    $$OrdersItemsTableOrderingComposer,
    $$OrdersItemsTableProcessedTableManager,
    $$OrdersItemsTableInsertCompanionBuilder,
    $$OrdersItemsTableUpdateCompanionBuilder> {
  $$OrdersItemsTableProcessedTableManager(super.$state);
}

class $$OrdersItemsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $OrdersItemsTable> {
  $$OrdersItemsTableFilterComposer(super.$state);
  ColumnFilters<int> get itemId => $state.composableBuilder(
      column: $state.table.itemId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$OrdersItemsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $OrdersItemsTable> {
  $$OrdersItemsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get itemId => $state.composableBuilder(
      column: $state.table.itemId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$TodoItemsTableTableManager get todoItems =>
      $$TodoItemsTableTableManager(_db, _db.todoItems);
  $$OrdersItemsTableTableManager get ordersItems =>
      $$OrdersItemsTableTableManager(_db, _db.ordersItems);
}
