import 'package:hoptech_iot_app/modules/alarm/domain/repository/alarms/i_alarms_repository.dart';
import 'package:hoptech_iot_app/thingsboard_client.dart';
import 'package:hoptech_iot_app/utils/usecase.dart';

class FetchAlarmsUseCase
    extends UseCase<Future<PageData<AlarmInfo>>, AlarmQueryV2> {
  const FetchAlarmsUseCase({required this.repository});

  final IAlarmsRepository repository;

  @override
  Future<PageData<AlarmInfo>> call(AlarmQueryV2 params) {
    return repository.fetchAlarms(params);
  }
}
