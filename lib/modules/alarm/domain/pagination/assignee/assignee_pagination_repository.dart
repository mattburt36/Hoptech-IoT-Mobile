import 'package:hoptech_iot_app/modules/alarm/domain/entities/assignee_entity.dart';
import 'package:hoptech_iot_app/modules/alarm/domain/pagination/assignee/assignee_query_ctrl.dart';
import 'package:hoptech_iot_app/thingsboard_client.dart';
import 'package:hoptech_iot_app/utils/services/pagination_repository.dart';

final class AssigneePaginationRepository
    extends PaginationRepository<PageLink, AssigneeEntity> {
  AssigneePaginationRepository({
    required AssigneeQueryCtrl assigneeQueryCtrl,
    required this.onFetchPageData,
  }) : super(pageKeyController: assigneeQueryCtrl);

  final Future<PageData<AssigneeEntity>> Function(PageLink) onFetchPageData;

  @override
  Future<PageData<AssigneeEntity>> fetchPageData(PageLink pageKey)  {
    return onFetchPageData(pageKey);
  }
}
