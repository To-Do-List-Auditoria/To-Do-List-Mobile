import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/event/analytics_event.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/event/analytics_event_name.dart';

class AnalyticsController {
  final FirebaseFirestore firebaseFirestore;

  AnalyticsController({required this.firebaseFirestore});

  Future<void> log(AnalyticsEvent event) async {
    try {
      final response = firebaseFirestore.collection("logs");
      final logMap = {"event": event.name.text, "params": event.params};
      response.add(logMap..addAll({"date": DateTime.now().toIso8601String()}));
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
