// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlaceStore on _PlaceStore, Store {
  final _$loadingAtom = Atom(name: '_PlaceStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$successAtom = Atom(name: '_PlaceStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$inputAtom = Atom(name: '_PlaceStore.input');

  @override
  String get input {
    _$inputAtom.reportRead();
    return super.input;
  }

  @override
  set input(String value) {
    _$inputAtom.reportWrite(value, super.input, () {
      super.input = value;
    });
  }

  final _$langAtom = Atom(name: '_PlaceStore.lang');

  @override
  String get lang {
    _$langAtom.reportRead();
    return super.lang;
  }

  @override
  set lang(String value) {
    _$langAtom.reportWrite(value, super.lang, () {
      super.lang = value;
    });
  }

  final _$getSuggestionAsyncAction = AsyncAction('_PlaceStore.getSuggestion');

  @override
  Future<dynamic> getSuggestion() {
    return _$getSuggestionAsyncAction.run(() => super.getSuggestion());
  }

  @override
  String toString() {
    return '''
loading: ${loading},
success: ${success},
input: ${input},
lang: ${lang}
    ''';
  }
}
