import 'package:bloc_test/bloc_test.dart' as bloc_test;
import 'package:test/test.dart' as test;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:AMP/models/model.dart';
import 'package:AMP/services/blocs/progress_bloc.dart';
import 'package:AMP/services/blocs/checklist_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:AMP/services/api.dart';

class MockChecklistRepository extends Mock implements ChecklistRepository {}
class MockChecklistProgressRepository extends Mock implements ChecklistProgressRepository {}
class MockClient extends Mock implements http.Client {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  API.client = MockClient();

  test.group('ChecklistBloc', () {
    ChecklistRepository repository;
    ChecklistBloc bloc;
    Checklist control;

    setUp(() {
      repository = MockChecklistRepository();
      bloc = ChecklistBloc(repository);
      control = ChecklistRepository.maxwellChecklist;
    });

    tearDown(() {
      bloc.close();
    });

    test.test('throws AssertionError if ChecklistRepository is null', () {
      expect(() => ChecklistBloc(null), throwsA(isAssertionError));
    });

    group('ChecklistRequested', () {
      bloc_test.blocTest(
        'emits [LoadInProgress, LoadSuccess] when ChecklistRequested is fired and getChecklist succeeds',
        build: () => bloc,
        act: (bloc) => bloc.add(ChecklistRequested(checklistID: "Maxwell")),
        expect: () => [ChecklistLoadInProgress(), ChecklistLoadSuccess(control)],
      );
    });
  });

  test.group('ChecklistProgressBloc', () {
    ChecklistProgressRepository repository;
    ChecklistProgressBloc bloc;
    ChecklistProgress control;

    setUp(() {
      repository = MockChecklistProgressRepository();
      bloc = ChecklistProgressBloc(repository);
      control = ChecklistProgress([]);
    });

    tearDown(() {
      bloc.close();
    });

    test.test('throws AssertionError if ChecklistProgressRepository is null', () {
      expect(() => ChecklistProgressBloc(null), throwsA(isAssertionError));
    });

    group('ChecklistProgressUpdateTask', () {
      bloc_test.blocTest(
        'emits [LoadInProgress, LoadSuccess] when ChecklistProgressUpdateTask is fired and taskUpdated succeeds',
        build: () => bloc,
        act: (bloc) {
          final taskID = ChecklistRepository.maxwellChecklist.categories[0].tasks[0].id;
          control = ChecklistProgress([TaskStatus(taskID, Status.inProgress)]);
          bloc.add(ChecklistProgressUpdateTask(taskID, Status.inProgress));
        },
        expect: () => [ChecklistProgressLoadInProgress(), ChecklistProgressLoadSuccess(control)],
      );
    });
  });
}
