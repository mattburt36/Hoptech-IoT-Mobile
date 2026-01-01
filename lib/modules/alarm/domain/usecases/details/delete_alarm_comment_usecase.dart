import 'package:hoptech_iot_app/modules/alarm/domain/repository/details/i_alarm_details_repository.dart';
import 'package:hoptech_iot_app/thingsboard_client.dart';
import 'package:hoptech_iot_app/utils/usecase.dart';

final class DeleteAlarmCommentUseCase
    extends UseCase<Future<void>, DeleteCommentParams> {
  DeleteAlarmCommentUseCase(this.repository);

  final IAlarmDetailsRepository repository;

  @override
  Future<void> call(DeleteCommentParams params)  {
    return repository.deleteComment(
      params.alarmId,
      commentId: params.commentId,
    );
  }
}

final class DeleteCommentParams {
  const DeleteCommentParams({required this.alarmId, required this.commentId});

  final String commentId;
  final AlarmId alarmId;
}
