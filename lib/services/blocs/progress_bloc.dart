import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:AMP/models/model.dart';
import 'package:AMP/services/api.dart';

class ChecklistProgressRepository {
  Future<ChecklistProgress> getChecklistProgress() async {
    return API.getChecklistProgress();

    /// leaving the below for potential future use:
    // final prefs = await SharedPreferences.getInstance();
    // String state = prefs.getString("_checklistProgress");
    // ChecklistProgress progress;
    // if (state != null) {
    //   progress = ChecklistProgress.fromJson(jsonDecode(state));
    // } else {
    //   progress = ChecklistProgress({});
    // }
    // this._progress = progress;
    // return progress;
  }

  Future<ChecklistProgress> taskUpdated(int taskID, Status newStatus) async {
    return API.putChecklistProgress(taskID, newStatus);

    /// leaving the below for potential future use:
    // final prefs = await SharedPreferences.getInstance();
    // _progress.taskStates[taskID] = newStatus == Status.notStarted ? null : newStatus;
    // prefs.setString("_checklistProgress", jsonEncode(_progress).toString());
    // return progress;
  }
}

/// events!
abstract class ChecklistProgressEvent {}

class ChecklistProgressRequested extends ChecklistProgressEvent {}

class ChecklistProgressUpdateTask extends ChecklistProgressEvent {
  final int taskID;
  final Status status;

  ChecklistProgressUpdateTask(this.taskID, this.status);
}

/// states!
abstract class ChecklistProgressState extends Equatable {
  @override
  List<Object> get props => [];
}
class ChecklistProgressInitial extends ChecklistProgressState {}

class ChecklistProgressLoadInProgress extends ChecklistProgressState {}
class ChecklistProgressLoadSuccess extends ChecklistProgressState {
  final ChecklistProgress progress;

  ChecklistProgressLoadSuccess(this.progress);

  @override
  List<Object> get props => [progress];
}
class ChecklistProgressLoadFailure extends ChecklistProgressState {
  final Exception error;

  ChecklistProgressLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}

/// mapping events to states!
class ChecklistProgressBloc extends Bloc<ChecklistProgressEvent, ChecklistProgressState> {
  final ChecklistProgressRepository _repository;

  ChecklistProgressBloc([ChecklistProgressRepository repository])
    : assert(repository != null),
      this._repository = repository,
      super(ChecklistProgressInitial());

  @override
  Stream<ChecklistProgressState> mapEventToState(ChecklistProgressEvent event) async* {
    if (event is ChecklistProgressRequested) {
      yield ChecklistProgressLoadInProgress();
      try {
        ChecklistProgress progress = await _repository.getChecklistProgress();
        yield ChecklistProgressLoadSuccess(progress);
      } catch (error) {
        yield ChecklistProgressLoadFailure(error);
      }
    } else if (event is ChecklistProgressUpdateTask) {
      yield ChecklistProgressLoadInProgress();
      try {
        ChecklistProgress progress = await _repository.taskUpdated(event.taskID, event.status);
        yield ChecklistProgressLoadSuccess(progress);
      } catch (error) {
        yield ChecklistProgressLoadFailure(error);
      }
    }
  }

  @override
  void onChange(Change<ChecklistProgressState> change) {
    print("progressBloc change: $change");
    super.onChange(change);
  }
}
