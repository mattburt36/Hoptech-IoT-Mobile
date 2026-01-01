import 'package:hoptech_iot_app/config/routes/router.dart';
import 'package:hoptech_iot_app/core/entity/entities_base.dart';
import 'package:hoptech_iot_app/locator.dart';
import 'package:hoptech_iot_app/thingsboard_client.dart';

mixin TenantsBase on EntitiesBase<Tenant, PageLink> {
  @override
  String get title => 'Tenants';

  @override
  String get noItemsFoundText => 'No tenants found';

  @override
  Future<PageData<Tenant>> fetchEntities(PageLink pageLink, {bool refresh = false}) {
    return tbClient.getTenantService().getTenants(pageLink);
  }

  @override
  void onEntityTap(Tenant tenant) {
    getIt<ThingsboardAppRouter>().navigateTo('/tenant/${tenant.id!.id}');
  }
}
