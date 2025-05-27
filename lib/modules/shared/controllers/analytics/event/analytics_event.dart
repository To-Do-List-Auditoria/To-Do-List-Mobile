import 'package:todo_list_auditoria/modules/shared/controllers/analytics/event/analytics_event_name.dart';

class AnalyticsEvent {
  AnalyticsEventName name;
  Map<String, Object>? params;

  AnalyticsEvent({required this.name, this.params});
}
