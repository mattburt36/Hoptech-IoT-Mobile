import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:hoptech_iot_app/config/routes/tb_routes.dart';
import 'package:hoptech_iot_app/modules/home/home_page.dart';

class HomeRoutes extends TbRoutes {
  HomeRoutes(super.tbContext);
  late Handler homeHandler = Handler(
    handlerFunc: (BuildContext? context, params) {
      return HomePage(tbContext);
    },
  );

  @override
  void doRegisterRoutes(FluroRouter router) {
    router.define('/home', handler: homeHandler);
  }
}
