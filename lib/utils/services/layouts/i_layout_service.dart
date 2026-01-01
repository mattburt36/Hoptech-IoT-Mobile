import 'package:flutter/cupertino.dart';
import 'package:hoptech_iot_app/core/context/tb_context.dart';
import 'package:hoptech_iot_app/modules/main/main_navigation_item.dart';
import 'package:hoptech_iot_app/thingsboard_client.dart';

abstract interface class ILayoutService {
  List<TbMainNavigationItem> getBottomBarItems();

  void setDeviceScreenSize(Size size, {required Orientation orientation});

  void setBottomBarItems(
    List<TbMainNavigationItem> items, {
    required TbMainNavigationItem more,
  });

  List<TbMainNavigationItem> getMorePageItems(
    TbContext tbContext,
    BuildContext context,
  );

  void cachePageLayouts(
    List<PageLayout>? pages, {
    required Authority authority,
  });

  List<PageLayout> getCachedPageLayouts();
}
