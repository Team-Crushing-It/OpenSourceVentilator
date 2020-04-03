import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/stats.dart';

class FirebaseService {
  final StreamController<Stats> _statsController = StreamController<Stats>();

  FirebaseService() {
    Firestore.instance
        .collection('informations')
        .document('project_stats')
        .snapshots()
        .listen(_statsUpdated);
  }

  // Exposes the stream publicly so that our models can listen to it. 
  Stream<Stats> get appStats => _statsController.stream;

  // This function will convert the snapshot to a Stats object and put it into a stream
  void _statsUpdated(DocumentSnapshot snapshot) {
    _statsController.add(Stats.fromSnapshot(snapshot));
  }
}
