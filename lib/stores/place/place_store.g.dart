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

  final _$geocodingResultsStartAtom =
      Atom(name: '_PlaceStore.geocodingResultsStart');

  @override
  List<GeocodingResult>? get geocodingResultsStart {
    _$geocodingResultsStartAtom.reportRead();
    return super.geocodingResultsStart;
  }

  @override
  set geocodingResultsStart(List<GeocodingResult>? value) {
    _$geocodingResultsStartAtom.reportWrite(value, super.geocodingResultsStart,
        () {
      super.geocodingResultsStart = value;
    });
  }

  final _$geocodingResultsEndAtom =
      Atom(name: '_PlaceStore.geocodingResultsEnd');

  @override
  List<GeocodingResult>? get geocodingResultsEnd {
    _$geocodingResultsEndAtom.reportRead();
    return super.geocodingResultsEnd;
  }

  @override
  set geocodingResultsEnd(List<GeocodingResult>? value) {
    _$geocodingResultsEndAtom.reportWrite(value, super.geocodingResultsEnd, () {
      super.geocodingResultsEnd = value;
    });
  }

  final _$geocodingResultStartAtom =
      Atom(name: '_PlaceStore.geocodingResultStart');

  @override
  GeocodingResult? get geocodingResultStart {
    _$geocodingResultStartAtom.reportRead();
    return super.geocodingResultStart;
  }

  @override
  set geocodingResultStart(GeocodingResult? value) {
    _$geocodingResultStartAtom.reportWrite(value, super.geocodingResultStart,
        () {
      super.geocodingResultStart = value;
    });
  }

  final _$geocodingResultEndAtom = Atom(name: '_PlaceStore.geocodingResultEnd');

  @override
  GeocodingResult? get geocodingResultEnd {
    _$geocodingResultEndAtom.reportRead();
    return super.geocodingResultEnd;
  }

  @override
  set geocodingResultEnd(GeocodingResult? value) {
    _$geocodingResultEndAtom.reportWrite(value, super.geocodingResultEnd, () {
      super.geocodingResultEnd = value;
    });
  }

  final _$getSuggestionStartAsyncAction =
      AsyncAction('_PlaceStore.getSuggestionStart');

  @override
  Future<dynamic> getSuggestionStart() {
    return _$getSuggestionStartAsyncAction
        .run(() => super.getSuggestionStart());
  }

  final _$getSuggestionEndAsyncAction =
      AsyncAction('_PlaceStore.getSuggestionEnd');

  @override
  Future<dynamic> getSuggestionEnd() {
    return _$getSuggestionEndAsyncAction.run(() => super.getSuggestionEnd());
  }

  final _$resetStartAsyncAction = AsyncAction('_PlaceStore.resetStart');

  @override
  Future<dynamic> resetStart() {
    return _$resetStartAsyncAction.run(() => super.resetStart());
  }

  final _$resetEndAsyncAction = AsyncAction('_PlaceStore.resetEnd');

  @override
  Future<dynamic> resetEnd() {
    return _$resetEndAsyncAction.run(() => super.resetEnd());
  }

  @override
  String toString() {
    return '''
loading: ${loading},
success: ${success},
input: ${input},
lang: ${lang},
geocodingResultsStart: ${geocodingResultsStart},
geocodingResultsEnd: ${geocodingResultsEnd},
geocodingResultStart: ${geocodingResultStart},
geocodingResultEnd: ${geocodingResultEnd}
    ''';
  }
}
