import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _mapboxToken =
      'pk.eyJ1IjoidGFkYW0tdGVjaCIsImEiOiJjbG1tbGp1dzAwNnJnMmxxZ2J1em1qcHptIn0.C_QneBb3pJYvZEUEufTlwg';
  String get mapboxToken => _mapboxToken;
  set mapboxToken(String _value) {
    _mapboxToken = _value;
  }

  DocumentReference? _selectedPlace;
  DocumentReference? get selectedPlace => _selectedPlace;
  set selectedPlace(DocumentReference? _value) {
    _selectedPlace = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
