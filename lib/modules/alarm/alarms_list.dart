import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:hoptech_iot_app/core/context/tb_context.dart';
import 'package:hoptech_iot_app/core/entity/entity_list_card.dart';
import 'package:hoptech_iot_app/generated/l10n.dart';
import 'package:hoptech_iot_app/locator.dart';
import 'package:hoptech_iot_app/modules/alarm/presentation/bloc/alarms_bloc.dart';
import 'package:hoptech_iot_app/modules/alarm/presentation/bloc/alarms_events.dart';
import 'package:hoptech_iot_app/modules/alarm/presentation/widgets/alarms_card.dart';
import 'package:hoptech_iot_app/thingsboard_client.dart';
import 'package:hoptech_iot_app/utils/ui/pagination_widgets/first_page_exception_widget.dart';
import 'package:hoptech_iot_app/utils/ui/pagination_widgets/first_page_progress_builder.dart';
import 'package:hoptech_iot_app/utils/ui/pagination_widgets/new_page_progress_builder.dart';
import 'package:hoptech_iot_app/utils/ui/pagination_widgets/pagination_list_widget.dart';

class AlarmsList extends StatelessWidget {
  const AlarmsList({required this.tbContext, super.key});

  final TbContext tbContext;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => getIt<AlarmBloc>().add(
        const AlarmsRefreshPageEvent(),
      ),
      child: PaginationListWidget<AlarmQueryV2, AlarmInfo>(
        pagingController:
            getIt<AlarmBloc>().paginationRepository.pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, alarm, index) {
            return EntityListCard(
              alarm,
              entityCardWidgetBuilder: (_, alarm) {
                return AlarmCard(
                  tbContext,
                  alarm: alarm,
                );
              },
            );
          },
          firstPageProgressIndicatorBuilder: (_) =>
              const FirstPageProgressBuilder(),
          newPageProgressIndicatorBuilder: (_) =>
              const NewPageProgressBuilder(),
          noItemsFoundIndicatorBuilder: (context) =>
              FirstPageExceptionIndicator(
            title: S.of(context).noAlarmsFound,
            message: S.of(context).listIsEmptyText,
            onTryAgain: () => getIt<AlarmBloc>().add(
              const AlarmsRefreshPageEvent(),
            ),
          ),
        ),
      ),
    );
  }
}
