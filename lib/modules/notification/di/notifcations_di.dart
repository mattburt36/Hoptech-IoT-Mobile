import 'package:hoptech_iot_app/locator.dart';
import 'package:hoptech_iot_app/modules/notification/usecase/handle_notification_tap_usecase.dart';

abstract final class NotifcationsDi {
  static const _scopeName = 'NotifcationsDi';
  static void init() {
    getIt.pushNewScope(
      scopeName: _scopeName,
      init: (getIt) =>
          getIt.registerFactory(() => HandleNotificationTapUsecase()),
    );
  }

  static void dispose() {
    getIt.dropScope(_scopeName);
  }
}
