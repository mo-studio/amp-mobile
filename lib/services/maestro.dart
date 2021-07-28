import 'package:AMP/services/blocs/progress_bloc.dart';
import 'package:AMP/services/blocs/checklist_bloc.dart';

class Maestro {

  static ChecklistProgressRepository _repository = ChecklistProgressRepository();
  static ChecklistProgressBloc progressBloc;
  
  static ChecklistRepository _checklistRepository = ChecklistRepository();
  static ChecklistBloc checklistBloc;

  static void configure() {
    checklistBloc = ChecklistBloc(_checklistRepository);
    checklistBloc.add(ChecklistRequested(checklistID: "Maxwell"));

    progressBloc = ChecklistProgressBloc(_repository);
    progressBloc.add(ChecklistProgressRequested());
  }

}
