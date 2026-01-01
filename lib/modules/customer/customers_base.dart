import 'package:hoptech_iot_app/config/routes/router.dart';
import 'package:hoptech_iot_app/core/entity/entities_base.dart';
import 'package:hoptech_iot_app/locator.dart';
import 'package:hoptech_iot_app/thingsboard_client.dart';

mixin CustomersBase on EntitiesBase<Customer, PageLink> {
  @override
  String get title => 'Customers';

  @override
  String get noItemsFoundText => 'No customers found';

  @override
  Future<PageData<Customer>> fetchEntities(PageLink pageLink, {bool refresh = false}) {
    return tbClient.getCustomerService().getCustomers(pageLink);
  }

  @override
  void onEntityTap(Customer customer) {
    getIt<ThingsboardAppRouter>().navigateTo('/customer/${customer.id!.id}');
  }
}
