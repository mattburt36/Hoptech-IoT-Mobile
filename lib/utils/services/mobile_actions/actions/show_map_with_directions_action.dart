import 'package:hoptech_iot_app/utils/services/mobile_actions/actions/show_map_location_action.dart';
import 'package:hoptech_iot_app/utils/services/mobile_actions/widget_mobile_action_type.dart';

class ShowMapWithDirectionsAction  extends ShowMapLocationAction {
    @override
  WidgetMobileActionType get type => WidgetMobileActionType.mapDirection;
  @override
  Future<String>  getUrl(List args) => getMapUrl(args, true);
}