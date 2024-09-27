import 'package:shopme/core/enums/src/state_status.dart';

extension StateStatusX on StateStatus {
  bool get isInit => this == StateStatus.init;

  bool get isLoading => this == StateStatus.loading;

  bool get isSuccess => this == StateStatus.success;

  bool get isFailed => this == StateStatus.failed;

  bool get isDone => this == StateStatus.done;
}
