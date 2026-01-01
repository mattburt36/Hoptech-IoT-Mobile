import 'package:hoptech_iot_app/modules/alarm/domain/repository/details/i_alarm_details_repository.dart';
import 'package:hoptech_iot_app/thingsboard_client.dart';
import 'package:hoptech_iot_app/utils/usecase.dart';

class FetchAlarmCommentsUseCase
    extends UseCase<Future<PageData<AlarmCommentInfo>>, AlarmCommentsQuery> {
  const FetchAlarmCommentsUseCase(this.repository);

  final IAlarmDetailsRepository repository;

  @override
  Future<PageData<AlarmCommentInfo>> call(AlarmCommentsQuery params) {
    return repository.fetchAlarmComments(params);
  }
}
