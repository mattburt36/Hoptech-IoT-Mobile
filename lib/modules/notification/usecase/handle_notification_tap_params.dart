import 'package:hoptech_iot_app/core/context/tb_context.dart';
import 'package:hoptech_iot_app/thingsboard_client.dart';

class HandleNotificationTapParams {
  HandleNotificationTapParams(
      {required this.notification, required this.tbContext});

  final PushNotification notification;
  final TbContext tbContext;
}
