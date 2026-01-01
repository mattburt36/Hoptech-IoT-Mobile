import 'package:hoptech_iot_app/core/entity/entities_base.dart';
import 'package:hoptech_iot_app/core/entity/entities_list.dart';
import 'package:hoptech_iot_app/modules/asset/assets_base.dart';
import 'package:hoptech_iot_app/thingsboard_client.dart';

class AssetsList extends BaseEntitiesWidget<AssetInfo, PageLink>
    with AssetsBase, EntitiesListStateBase {
  AssetsList(
    super.tbContext,
    super.pageKeyController, {
    super.key,
   super.searchMode,
  });
}
