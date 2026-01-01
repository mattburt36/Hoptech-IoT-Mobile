import 'package:hoptech_iot_app/modules/alarm/domain/repository/details/i_alarm_details_repository.dart';
import 'package:hoptech_iot_app/thingsboard_client.dart';
import 'package:hoptech_iot_app/utils/usecase.dart';

final class UnassignAlarmUseCase extends UseCase<Future<AlarmInfo>, String> {
  const UnassignAlarmUseCase(this.repository);

  final IAlarmDetailsRepository repository;

  @override
  Future<AlarmInfo> call(String params) {
    return repository.unassignAlarm(params);
  }
}
