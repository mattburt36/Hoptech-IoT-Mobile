import 'package:hoptech_iot_app/thingsboard_client.dart';

abstract interface class IAlarmTypesRepository {
  Future<PageData<AlarmType>> fetchAlarmTypes(PageLink pageKey);
}
