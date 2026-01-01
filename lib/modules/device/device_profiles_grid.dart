import 'package:hoptech_iot_app/core/entity/entities_base.dart';
import 'package:hoptech_iot_app/core/entity/entities_grid.dart';
import 'package:hoptech_iot_app/modules/device/device_profiles_base.dart';
import 'package:hoptech_iot_app/thingsboard_client.dart';

class DeviceProfilesGrid extends BaseEntitiesWidget<DeviceProfileInfo, PageLink>
    with DeviceProfilesBase, EntitiesGridStateBase {
  DeviceProfilesGrid(
    super.tbContext,
    super.pageKeyController, {
    super.key,
  });
}
