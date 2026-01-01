import 'package:hoptech_iot_app/thingsboard_client.dart';

abstract interface class IAssigneeRepository {
  Future<PageData<UserInfo>> fetchAssignee(PageLink pageKey);
}
