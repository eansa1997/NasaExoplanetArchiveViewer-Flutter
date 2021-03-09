// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlanetsViewModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlanetsViewModel on PlanetsViewModelBase, Store {
  final _$planetsAtom = Atom(name: 'PlanetsViewModelBase.planets');

  @override
  Planets get planets {
    _$planetsAtom.reportRead();
    return super.planets;
  }

  @override
  set planets(Planets value) {
    _$planetsAtom.reportWrite(value, super.planets, () {
      super.planets = value;
    });
  }

  final _$isLoadingAtom = Atom(name: 'PlanetsViewModelBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$hadErrorAtom = Atom(name: 'PlanetsViewModelBase.hadError');

  @override
  bool get hadError {
    _$hadErrorAtom.reportRead();
    return super.hadError;
  }

  @override
  set hadError(bool value) {
    _$hadErrorAtom.reportWrite(value, super.hadError, () {
      super.hadError = value;
    });
  }

  final _$queryAsyncAction = AsyncAction('PlanetsViewModelBase.query');

  @override
  Future<void> query(String url) {
    return _$queryAsyncAction.run(() => super.query(url));
  }

  @override
  String toString() {
    return '''
planets: ${planets},
isLoading: ${isLoading},
hadError: ${hadError}
    ''';
  }
}
