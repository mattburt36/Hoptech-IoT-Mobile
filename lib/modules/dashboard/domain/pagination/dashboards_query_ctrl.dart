import 'package:hoptech_iot_app/core/entity/entities_base.dart';
import 'package:hoptech_iot_app/thingsboard_client.dart';

class DashboardsQueryCtrl extends PageKeyController<PageLink> {
  DashboardsQueryCtrl() : super(PageLink(20));

  @override
  PageLink nextPageKey(PageLink pageKey) {
    return pageKey.nextPageLink();
  }
}
