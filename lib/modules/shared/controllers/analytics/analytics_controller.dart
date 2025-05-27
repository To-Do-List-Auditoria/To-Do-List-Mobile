import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/event/analytics_event.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/event/analytics_event_name.dart';

class AnalyticsController {
  final FirebaseAnalytics firebaseAnalytics;

  AnalyticsController({required this.firebaseAnalytics});

  Future<void> log(AnalyticsEvent event) async {
    firebaseAnalytics.logEvent(name: event.name.text, parameters: event.params);
  }
}
