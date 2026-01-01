import 'package:hoptech_iot_app/config/routes/router.dart';
import 'package:hoptech_iot_app/core/entity/entities_base.dart';
import 'package:hoptech_iot_app/core/entity/entities_list_widget.dart';
import 'package:hoptech_iot_app/locator.dart';
import 'package:hoptech_iot_app/modules/device/devices_base.dart';
import 'package:hoptech_iot_app/thingsboard_client.dart';

class DevicesListWidget extends EntitiesListWidget<EntityData, EntityDataQuery>
    with DevicesBase {
  DevicesListWidget(
    super.tbContext, {
    super.key,
    super.controller,
  });

  @override
  void onViewAll() {
    getIt<ThingsboardAppRouter>().navigateTo('/devices');
  }

  @override
  PageKeyController<EntityDataQuery> createPageKeyController() =>
      DeviceQueryController(pageSize: 5);
}
