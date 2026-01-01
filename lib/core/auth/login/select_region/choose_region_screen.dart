import 'package:flutter/material.dart';
import 'package:hoptech_iot_app/config/routes/router.dart';
import 'package:hoptech_iot_app/core/auth/login/select_region/model/region.dart';
import 'package:hoptech_iot_app/core/auth/login/select_region/region_widget.dart';
import 'package:hoptech_iot_app/core/context/tb_context_widget.dart';
import 'package:hoptech_iot_app/generated/l10n.dart';
import 'package:hoptech_iot_app/locator.dart';
import 'package:hoptech_iot_app/utils/services/endpoint/i_endpoint_service.dart';
import 'package:hoptech_iot_app/utils/ui/tb_text_styles.dart';
import 'package:hoptech_iot_app/widgets/tb_app_bar.dart';

class ChooseRegionScreen extends TbContextStatelessWidget {
  ChooseRegionScreen(
    super.tbContext, {
    required this.nASelected,
    required this.europeSelected,
    super.key,
  });

  final bool nASelected;
  final bool europeSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TbAppBar(
        tbContext,
        title: Text(
          S.of(context).chooseRegion,
          style: TbTextStyles.titleXs.copyWith(
            color: Colors.black.withValues(alpha: .87),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RegionWidget(
                title: S.of(context).northAmerica,
                subTitle: S.of(context).northAmericaRegionShort,
                selected: nASelected,
                onTap: () {
                  getIt<IEndpointService>().setRegion(Region.northAmerica);
                  getIt<ThingsboardAppRouter>().navigateTo('/', replace: true);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: RegionWidget(
                  title: S.of(context).europe,
                  subTitle: S.of(context).europeRegionShort,
                  selected: europeSelected,
                  onTap: () {
                    getIt<IEndpointService>().setRegion(Region.europe);
                    getIt<ThingsboardAppRouter>().navigateTo(
                      '/',
                      replace: true,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
