import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

final Map<String, List<Entry>> dictionaries = {};
final Map<String, Concept> concepts = {};

Future<void> load(Iterable<String> languages) async {
  dictionaries.clear();
  await Future.wait(
    languages.map((l) {
      return FirebaseFirestore.instance
          .collection('languages/$l/dictionary')
          .withConverter(
            fromFirestore: (snapshot, _) => Entry.fromJson(snapshot.data()!),
            toFirestore: (Entry object, _) => object.toJson(),
          )
          .get()
          .then((d) {
        if (d.docs.isEmpty) return null;
        dictionaries[l] = d.docs.map((e) => e.data()).toList();
        return l;
      });
    }),
  );

  concepts.clear();
  await FirebaseFirestore.instance
      .collection('meta/dictionary/concepts')
      .withConverter(
        fromFirestore: (snapshot, _) => Concept.fromJson(snapshot.data()!),
        toFirestore: (Concept object, _) => object.toJson(),
      )
      .get()
      .then((d) {
    d.docs.forEach((d) => concepts[d.id] = d.data());
  });
}
