// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NASATables.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NASATables on NASATablesBase, Store {
  final _$selectedTableAtom = Atom(name: 'NASATablesBase.selectedTable');

  @override
  int get selectedTable {
    _$selectedTableAtom.reportRead();
    return super.selectedTable;
  }

  @override
  set selectedTable(int value) {
    _$selectedTableAtom.reportWrite(value, super.selectedTable, () {
      super.selectedTable = value;
    });
  }

  final _$tableNamesAtom = Atom(name: 'NASATablesBase.tableNames');

  @override
  Map<int, String> get tableNames {
    _$tableNamesAtom.reportRead();
    return super.tableNames;
  }

  @override
  set tableNames(Map<int, String> value) {
    _$tableNamesAtom.reportWrite(value, super.tableNames, () {
      super.tableNames = value;
    });
  }

  final _$selectedColumnIsCheckedAtom =
      Atom(name: 'NASATablesBase.selectedColumnIsChecked');

  @override
  List<bool> get selectedColumnIsChecked {
    _$selectedColumnIsCheckedAtom.reportRead();
    return super.selectedColumnIsChecked;
  }

  @override
  set selectedColumnIsChecked(List<bool> value) {
    _$selectedColumnIsCheckedAtom
        .reportWrite(value, super.selectedColumnIsChecked, () {
      super.selectedColumnIsChecked = value;
    });
  }

  final _$selectedColumnsAtom = Atom(name: 'NASATablesBase.selectedColumns');

  @override
  Set<int> get selectedColumns {
    _$selectedColumnsAtom.reportRead();
    return super.selectedColumns;
  }

  @override
  set selectedColumns(Set<int> value) {
    _$selectedColumnsAtom.reportWrite(value, super.selectedColumns, () {
      super.selectedColumns = value;
    });
  }

  final _$exoplanetsAtom = Atom(name: 'NASATablesBase.exoplanets');

  @override
  Map<int, String> get exoplanets {
    _$exoplanetsAtom.reportRead();
    return super.exoplanets;
  }

  @override
  set exoplanets(Map<int, String> value) {
    _$exoplanetsAtom.reportWrite(value, super.exoplanets, () {
      super.exoplanets = value;
    });
  }

  final _$compositeParsAtom = Atom(name: 'NASATablesBase.compositePars');

  @override
  Map<int, String> get compositePars {
    _$compositeParsAtom.reportRead();
    return super.compositePars;
  }

  @override
  set compositePars(Map<int, String> value) {
    _$compositeParsAtom.reportWrite(value, super.compositePars, () {
      super.compositePars = value;
    });
  }

  @override
  String toString() {
    return '''
selectedTable: ${selectedTable},
tableNames: ${tableNames},
selectedColumnIsChecked: ${selectedColumnIsChecked},
selectedColumns: ${selectedColumns},
exoplanets: ${exoplanets},
compositePars: ${compositePars}
    ''';
  }
}
