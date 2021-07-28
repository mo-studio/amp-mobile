import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:AMP/widgets/TaskDetail.dart';
import 'package:AMP/models/model.dart';
import 'package:AMP/services/blocs/progress_bloc.dart';
import 'package:AMP/services/blocs/checklist_bloc.dart';
import 'package:AMP/services/blocs/auth_bloc.dart';
import 'package:AMP/services/auth.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }
  
  int count(ChecklistProgress progress, Checklist checklist, Status status, int categoryID) {
    List<int> taskIDs = checklist.categories.firstWhere((category) => category.id == categoryID).tasks.map((task) => task.id).toList();
    return taskIDs.fold(0, (count, taskID) {
      final taskStatus = progress.status(taskID);
      if (status == Status.notStarted && taskStatus == null) {
        count++;
      } else if (taskStatus == status) {
        count++;
      }
      return count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AMP Inprocessing'), 
        automaticallyImplyLeading: false,
        actions: [
          Padding(child:
          GestureDetector(
            onTap: () {
              _showLogoutDialog();
            },
            child: Icon(
              Icons.logout,
            ),
          ), padding: EdgeInsets.only(right: 10.0))
        ],),
      body: BlocConsumer<ChecklistBloc, ChecklistState>(
        listener: (context, checklistState) {
          
        },
        builder: (context, checklistState) {
          if (checklistState is ChecklistLoadFailure) {
            return Text("Error loading checklist: $checklistState.error");
          } else {
            return BlocConsumer<ChecklistProgressBloc, ChecklistProgressState>(
              listener: (context, progressState) {
                if (checklistState is ChecklistLoadSuccess && progressState is ChecklistProgressLoadSuccess) {
                  _refreshCompleter.complete();
                  _refreshCompleter = Completer();
                }
              },
              builder: (context, progressState) {
                if (checklistState is ChecklistLoadSuccess && progressState is ChecklistProgressLoadSuccess) {
                  final checklist = checklistState.checklist;
                  return RefreshIndicator(
                    child: ListView.separated(
                      itemCount: checklist.categories.length,
                      itemBuilder: (context, index) {
                        final category = checklist.categories[index];
                        final theme = Theme.of(context).copyWith(dividerColor: Colors.lightBlue.withAlpha(0));
                        return Theme(
                          data: theme, 
                          child: Padding(
                            padding: EdgeInsets.all(6.0), 
                            child: ExpansionTile(
                              key: new PageStorageKey<String>(category.title),
                              title: Text(category.title, style: TextStyle(fontWeight: FontWeight.w500)),
                              subtitle: Row(
                                children: [
                                  SizedBox(height: 10, width: 10, child: Status.notStarted.avatar(10)),
                                  SizedBox(width: 5),
                                  Text("${count(progressState.progress, checklistState.checklist, Status.notStarted, category.id)}"), 
                                  SizedBox(width: 10),
                                  SizedBox(height: 10, width: 10, child: Status.inProgress.avatar(10)),
                                  SizedBox(width: 5),
                                  Text("${count(progressState.progress, checklistState.checklist, Status.inProgress, category.id)}"),
                                  SizedBox(width: 10),
                                  SizedBox(height: 10, width: 10, child: Status.pendingVerification.avatar(10)),
                                  SizedBox(width: 5),
                                  Text("${count(progressState.progress, checklistState.checklist, Status.pendingVerification, category.id)}"),
                                  SizedBox(width: 10),
                                  SizedBox(height: 10, width: 10, child: Status.completed.avatar(10)),
                                  SizedBox(width: 5),
                                  Text("${count(progressState.progress, checklistState.checklist, Status.completed, category.id)}")
                                ],
                              ),
                              leading: Icon(Icons.folder),
                              children: category.tasks.map((task) {
                                return Column(
                                  children: [
                                    Divider(color: Colors.grey.withAlpha(100), indent: 10),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(4, 3, 4, 3), 
                                      child: ListTile(
                                        leading: SizedBox(
                                          height: 25, 
                                          width: 25,
                                          child: progressState.progress.status(task.id).avatar(30)
                                        ),
                                        trailing: Icon(Icons.keyboard_arrow_right),
                                        title: Text(task.title, style: TextStyle(fontSize: 14)),
                                        onTap: () {
                                          _navigateToTaskDetail(task, BlocProvider.of<ChecklistProgressBloc>(context));
                                        }
                                      )
                                    )
                                  ],
                                );
                              }).toList()
                            )
                          )
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                    ),
                    onRefresh: () {
                      BlocProvider.of<ChecklistBloc>(context).add(ChecklistRequested(checklistID: "Maxwell"));
                      BlocProvider.of<ChecklistProgressBloc>(context).add(ChecklistProgressRequested());
                      return _refreshCompleter.future;
                    },
                  );
                } else if (progressState is ChecklistProgressLoadFailure) {
                  return Text("Error loading progress: $progressState.error");
                } else {
                  return Center(child: CircularProgressIndicator(value: null));
                }
              }
            );
          }
        }
      )
    );
  }

  void _navigateToTaskDetail(Task task, ChecklistProgressBloc bloc) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return BlocProvider.value(
            value: bloc,
            child: TaskDetail(task)
          );
        }
      )
    );
  }

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              }
            ),
            TextButton(
              child: Text('Log Out', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                bool success = await logout();
                if (success) {
                  Navigator.of(context).pop();
                  BlocProvider.of<AuthBloc>(context).add(AuthLogOut());
                }
              },
            ),
          ],
        );
      },
    );
  }
}
