import 'package:hoptech_iot_app/core/entity/entities_base.dart';
import 'package:hoptech_iot_app/core/entity/entities_list.dart';
import 'package:hoptech_iot_app/modules/tenant/tenants_base.dart';
import 'package:hoptech_iot_app/thingsboard_client.dart';

class TenantsList extends BaseEntitiesWidget<Tenant, PageLink>
    with TenantsBase, ContactBasedBase, EntitiesListStateBase {
  TenantsList(
    super.tbContext,
    super.pageKeyController, {
  super.searchMode,
    super.key,
  });
}
