import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:AMP/models/model.dart';
import 'package:AMP/services/phone_number_linkifier.dart';
import 'package:AMP/services/blocs/progress_bloc.dart';

class TaskDetail extends StatefulWidget {

  final Task task;

  TaskDetail(this.task);

  @override
  _TaskDetailState createState() =>
      _TaskDetailState(this.task);

}

class _TaskDetailState extends State<TaskDetail> {
  
  final Task task;
  
  bool issueHasBeenReported = false;

  _TaskDetailState(this.task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Details')),
      body: BlocBuilder<ChecklistProgressBloc, ChecklistProgressState>(
        builder: (context, progressState) {
          if (progressState is ChecklistProgressLoadSuccess) {
            Status status = progressState.progress.status(task.id);
            return Container(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(task.title,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 24)
                      ),
                      SizedBox(height: 24),
                      Linkify(
                        linkifiers: [
                          UrlLinkifier(),
                          EmailLinkifier(),
                          PhoneNumberLinkifier()
                        ],
                        text: task.text,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.65)),
                        onOpen: (element) {
                          launch(element.url);
                        },
                      ),
                      SizedBox(height: 24),
                      if (task.verificationRequired)
                        VerificationStatus(status),
                      SizedBox(height: 24),
                      FractionallySizedBox(
                        widthFactor: 1.0,
                        child: CupertinoSlidingSegmentedControl(
                          children: {
                            /// we actually only need to have one sized and centered text widget here
                            /// and the rest will remain centered (#performance?)
                            /// (there's no height on the segmented control and wrapping the fractionally
                            /// sized box in a height-sized or overflow box didn't work)
                            Status.notStarted: SizedBox(
                                height: 48,
                                child: Center(child: Text("Not Started"))),
                            Status.inProgress: Text("In Progress"),
                            Status.completed: Text("Completed"),
                          },
                          onValueChanged: (newStatus) {
                            if (newStatus == Status.completed && task.verificationRequired) {
                              _updateTaskStatus(Status.pendingVerification, context);
                            } else {
                              _updateTaskStatus(newStatus, context);
                            }
                          },
                          groupValue: status == Status.pendingVerification ? Status.completed : status,
                          thumbColor: (status == Status.pendingVerification ? Status.completed : status).color
                        )
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                        /* Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.5,
                        child: ElevatedButton(
                          child: Text("Report Issue"),
                          onPressed: (issueHasBeenReported)
                            ? null
                            : showSubmitIssueDialog,
                          style: ElevatedButton.styleFrom(primary: Theme.of(context).accentColor, onPrimary: Colors.white)
                        )
                      )
                    ]
                  )*/
                ]
              )
            );
          } else if (progressState is ChecklistProgressLoadInProgress) {
            return Center(child: CircularProgressIndicator(value: null));
          } else {
            return Text("Error loading task progress");
          }
        }
      )
    );
  }

  void _updateTaskStatus(Status newStatus, BuildContext context) {
    BlocProvider.of<ChecklistProgressBloc>(context).add(ChecklistProgressUpdateTask(task.id, newStatus));
  }

  /* void showSubmitIssueDialog() {
    showDialog(
      context: context,
      barrierDismissible:
          false, // disables the ability to tap outside of the dialog to dismiss it
      builder: (BuildContext context) {
        bool wrongAddressChecked = false;
        bool wrongNumberChecked = false;

        return StatefulBuilder(builder: (context, setAlertState) {
          return new AlertDialog(
            title: new Text('Report Issue'),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: [
                  CheckboxListTile(
                    title: Text("Wrong Address"),
                    value: wrongAddressChecked,
                    onChanged: (bool value) {
                      setAlertState(() {
                        wrongAddressChecked = value;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text("Wrong Number"),
                    value: wrongNumberChecked,
                    onChanged: (bool value) {
                      setAlertState(() {
                        wrongNumberChecked = value;
                      });
                    },
                  ),
                  new Text('Please describe what is wrong with this task'),
                  new TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ],
              ),
            ),
            actions: [
              new FlatButton(
                child: new Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('Send'),
                onPressed: () {
                  setState(() {
                    issueHasBeenReported = true;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      },
    );
  }*/
}

class VerificationStatus extends StatefulWidget {

  final Status status;

  VerificationStatus(this.status);

  @override
  _VerificationStatusState createState() => _VerificationStatusState(this.status);
}

class _VerificationStatusState extends State<VerificationStatus> {

  final Status status;

  _VerificationStatusState(this.status);

  @override
  Widget build(BuildContext context) {
    Icon icon;
    Text text;
    switch (status) {
      case Status.notStarted:
        icon = Icon(Icons.warning, color: Colors.red);
        text = Text("Verification Required", style: TextStyle(color: Colors.red));
        break;
      case Status.inProgress:
        icon = Icon(Icons.warning, color: Colors.red);
        text = Text("Verification Required", style: TextStyle(color: Colors.red));
        break;
      case Status.pendingVerification:
        icon = Icon(Icons.more_horiz, color: Colors.purple);
        text = Text("Verification Pending", style: TextStyle(color: Colors.purple));
        break;
      case Status.completed:
        icon = Icon(Icons.check, color: Colors.green);
        text = Text("Verified", style: TextStyle(color: Colors.green));
        break;
      default:
    }
    return Row(children: [icon, SizedBox(width: 10), text], mainAxisAlignment: MainAxisAlignment.center,);
  }
}
