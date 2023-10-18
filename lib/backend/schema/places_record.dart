import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlacesRecord extends FirestoreRecord {
  PlacesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "latLng" field.
  LatLng? _latLng;
  LatLng? get latLng => _latLng;
  bool hasLatLng() => _latLng != null;

  // "nom" field.
  String? _nom;
  String get nom => _nom ?? '';
  bool hasNom() => _nom != null;

  // "adresse" field.
  String? _adresse;
  String get adresse => _adresse ?? '';
  bool hasAdresse() => _adresse != null;

  // "commune" field.
  String? _commune;
  String get commune => _commune ?? '';
  bool hasCommune() => _commune != null;

  void _initializeFields() {
    _latLng = snapshotData['latLng'] as LatLng?;
    _nom = snapshotData['nom'] as String?;
    _adresse = snapshotData['adresse'] as String?;
    _commune = snapshotData['commune'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('places');

  static Stream<PlacesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlacesRecord.fromSnapshot(s));

  static Future<PlacesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PlacesRecord.fromSnapshot(s));

  static PlacesRecord fromSnapshot(DocumentSnapshot snapshot) => PlacesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlacesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlacesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlacesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlacesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlacesRecordData({
  LatLng? latLng,
  String? nom,
  String? adresse,
  String? commune,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'latLng': latLng,
      'nom': nom,
      'adresse': adresse,
      'commune': commune,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlacesRecordDocumentEquality implements Equality<PlacesRecord> {
  const PlacesRecordDocumentEquality();

  @override
  bool equals(PlacesRecord? e1, PlacesRecord? e2) {
    return e1?.latLng == e2?.latLng &&
        e1?.nom == e2?.nom &&
        e1?.adresse == e2?.adresse &&
        e1?.commune == e2?.commune;
  }

  @override
  int hash(PlacesRecord? e) =>
      const ListEquality().hash([e?.latLng, e?.nom, e?.adresse, e?.commune]);

  @override
  bool isValidKey(Object? o) => o is PlacesRecord;
}
