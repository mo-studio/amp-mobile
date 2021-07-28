import 'dart:ui';
import 'package:AMP/widgets/Welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'package:bloc_test/bloc_test.dart';
import 'package:AMP/widgets/CategoryList.dart';
import 'package:AMP/widgets/TaskDetail.dart';
import 'package:AMP/services/maestro.dart';
import 'package:AMP/models/model.dart';
import 'package:AMP/services/blocs/checklist_bloc.dart';
import 'package:AMP/services/blocs/progress_bloc.dart';

Type typeOf<T>() => T;

class MockChecklistBloc extends MockBloc<ChecklistEvent, ChecklistState> implements ChecklistBloc {}
class MockProgressBloc extends MockBloc<ChecklistProgressEvent, ChecklistProgressState> implements ChecklistProgressBloc {}

void main() {
  group('widget smoke tests', () {
    // Maestro.configureFor("Amn", "Maxwell");
    Maestro.configure();
    // SharedPreferences.setMockInitialValues({});

    ChecklistBloc checklistBloc;
    ChecklistProgressBloc progressBloc;

    setUp(() {
      checklistBloc = MockChecklistBloc();
      progressBloc = MockProgressBloc();
    });

    tearDown(() {
      checklistBloc.close();
      progressBloc.close();
    });

    testWidgets('Welcome', (WidgetTester tester) async {
      // set tester resolution to iPhone SE (smallest iOS device capable of running AMP)
      await tester.binding.setSurfaceSize(Size(1136, 640));
      await tester.pumpWidget(MaterialApp(home: Welcome()));
      expect(find.text('Welcome to Airmen Mobile Processing'), findsOneWidget);
    });

    testWidgets('CategoryList', (WidgetTester tester) async {
      mockito.when(checklistBloc.state).thenReturn(ChecklistLoadSuccess(ChecklistRepository.maxwellChecklist));
      mockito.when(progressBloc.state).thenReturn(ChecklistProgressLoadSuccess(ChecklistProgress([])));
      await tester.binding.setSurfaceSize(Size(1136, 640));
      await tester.pumpWidget(MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: checklistBloc),
              BlocProvider.value(value: progressBloc)
            ], 
            child: CategoryList()
          )
        )
      );
      
      for (Category category in ChecklistRepository.maxwellChecklist.categories) {
        expect(find.text(category.title), findsOneWidget);
        expect(find.byType(Status.notStarted.avatar(10).runtimeType), findsWidgets);
        expect(find.byType(Status.inProgress.avatar(10).runtimeType), findsWidgets);
        expect(find.byType(Status.completed.avatar(10).runtimeType), findsWidgets);
        // expect(find.text("${category.count(Status.notStarted)}"), findsWidgets);
        // expect(find.text("${category.count(Status.inProgress)}"), findsWidgets);
        // expect(find.text("${category.count(Status.complete)}"), findsWidgets);
      }
      expect(find.byType(ExpansionTile), findsWidgets);
    });

    testWidgets('TaskDetail', (WidgetTester tester) async {
      mockito.when(progressBloc.state).thenReturn(ChecklistProgressLoadSuccess(ChecklistProgress([])));
      await tester.binding.setSurfaceSize(Size(1136, 640));
      final task = Task(id: 1234, title: "Get this thing from that person.", text: "Call that person at this number: 123-456-7890");
      await tester.pumpWidget(MaterialApp(
        home: BlocProvider.value(value: progressBloc, child: TaskDetail(task)))
      );
      expect(find.text(task.title), findsOneWidget);
      expect(find.text(task.text), findsOneWidget);
      expect(find.byType(typeOf<CupertinoSlidingSegmentedControl<Status>>()), findsOneWidget);
      expect(find.text('Not Started'), findsOneWidget);
      expect(find.text('In Progress'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);
    });
  });
}