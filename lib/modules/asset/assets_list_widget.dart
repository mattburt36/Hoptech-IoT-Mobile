import 'package:hoptech_iot_app/config/routes/router.dart';
import 'package:hoptech_iot_app/core/entity/entities_list_widget.dart';
import 'package:hoptech_iot_app/locator.dart';
import 'package:hoptech_iot_app/modules/asset/assets_base.dart';
import 'package:hoptech_iot_app/thingsboard_client.dart';

class AssetsListWidget extends EntitiesListPageLinkWidget<AssetInfo>
    with AssetsBase {
  AssetsListWidget(
    super.tbContext, {
    super.key,
    super.controller,
  });

  @override
  void onViewAll() {
    getIt<ThingsboardAppRouter>().navigateTo('/assets');
  }
}
