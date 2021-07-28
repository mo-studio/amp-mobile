import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:AMP/models/model.dart';
import 'package:AMP/services/api.dart';

class ChecklistRepository {
  Future<Checklist> getChecklist(String checklistID) async {
    return API.getChecklist();
  }

  static final maxwellChecklist = Checklist.fromJson(jsonDecode('''{
  "title": "Military Newcoming / In-Processing Checklist",
  "subtitle": "DET 5, Air Force Lifecycle Management Center (AFLCMC) Gunter Annex, AL",
  "description": "In-Processing is a military appointment. Military uniform is mandatory. Digital signatures will be required for each field before final signature. **NEWCOMERS MUST COMPLETE 14-DAY QUARANTINE**",
  "categories": [
    {
      "id": 0,
      "title": "Sponsor Actions",
      "tasks":[
        {
          "id": 0,
          "title": "Email DET 5/CSS with Newcomer's Orders",
          "text": "Send/Email to AFLCMC Det 5 Personnel Workflow",
          "verificationRequired": false
        },
        {
          "id": 1,
          "title": "Email DET 5/CSS current AFFMS II Fitness Report",
          "text": "Send/Email to AFLCMC Det 5 Personnel Workflow",
          "verificationRequired": false
        },
        {
          "id": 2,
          "title": "Email DET 5/CSS Member's ROM LILO",
          "text": "Send copy of ROM (Letter In Liue Of) from member's loosing MPF",
          "verificationRequired": false
        }
      ]
    },
    {
      "id": 1,
      "title": "Newcomer's Appointments",
      "tasks": [
        {
          "id": 3,
          "title": "For Finance",
          "text": "-Receipts (TLE/Non-Availability/Airline Tickets…etc) \\n -BAH Waiver’s \\n -ROM Letter ",
          "verificationRequired": false
        },
        {
          "id": 4,
          "title": "If First Term Airman (FTA)",
          "text": "-BMT Certificate \\n -Tech School Certificate \\n -DD4 Enlistment Document",
          "verificationRequired": false
        },
        {
          "id": 5,
          "title": "For the MPS",
          "text": "-ROM Letter \\n-Completed IDA Worksheet \\n-Endorsed/Signed Orders \\n-AF Form 330 Records Transmittal \\n-PT Score Card \\n-Sealed Packet/Envelope from last duty station \\n-5 Copies of orders and amendments \\n-Marriage/Birth Certificate (Only if member was married, divorced, had child…etc ",
          "verificationRequired": false
        },
        {
          "id": 6,
          "title": "42nd MPS & Finance In-Processing",
          "text": "-Maxwell AFB, Bldg 804, Customer Service Lobby. Every Monday and Wednesday @ 0900 \\n-Member’s must hand carry the below source documents received from the Det 5/CSS to this appointment.",
          "verificationRequired": false
        },
        {
          "id": 7,
          "title": "Right Start - All Airmen",
          "text": "-Please sign up by calling or emailing Ms. Rebecca Hackett \\nURL: https://www.google.com Phone: 770-953-3791 \\nEmail: rebecca.hackett.2@us.af.mil \\n-Newcomer’s Right Start Orientation sign in begins at 0730 at the Maxwell Club, Bldg 144. Please be in place by 0745. Please do not bring food or beverages into the facility. Right Start is mandatory and should be completed within 30 days of in-processing. Medical Right Start is for Active Duty Military only and will begin at 1330 at the Maxwell Clinic, Bldg 760 (3rd Floor Classroom). Please bring a copy of your orders. Spouses are invited to attend 0730-1230. ",
          "verificationRequired": false
        },
        {
          "id": 8,
          "title": "First Term Airman Center (FTAC): First Duty Station Airmen Only",
          "text": "-Please sign up at: https://cs3.eis.af.mil/site/er/0291/SitePages/Home.aspx \\n-Location: Bldg 501, Rm 112, report time is 0730. \\n-Description: This is an introductory course for all First Term Airman arriving at Maxwell/Gunter as their first duty station. This course is mandated by the Air Force. ABU’s/OCP’s are the UOD.",
          "verificationRequired": false
        },
        {
          "id": 9,
          "title": "Schedule BES/SUPT One-on-One Brief",
          "text": "-Sponsor email the Chief's Exec: SrA McCash, Courtney: courtney.mccash@us.af.mil",
          "verificationRequired": false
        },
        {
          "id": 10,
          "title": "Schedule DET 5/First Sergeant One-on-One Brief",
          "text": "-Sponsor email the CC Exec at “Gunter AFLCMC Det5/CC Workflow” esc.det1.cc@us.af.mil",
          "verificationRequired": false
        },
        {
          "id": 11,
          "title": "Schedule DET 5/Commander One-on-One Brief",
          "text": "-Sponsor email the CC Exec at “Gunter AFLCMC Det5/CC Workflow” esc.det1.cc@us.af.mil",
          "verificationRequired": false
        }
      ]
    },
    {
      "id": 2,
      "title": "Member's Actions",
      "tasks": [
        {
          "id": 12,
          "title": "Report to your Division Admin for Internal In-Processing Procedures",
          "text": "",
          "verificationRequired": false
        },
        {
          "id": 13,
          "title": "Recall Roster Contact Information",
          "text": "-In your duty Section",
          "verificationRequired": false
        },
        {
          "id": 14,
          "title": "Virtual Record of Emergency Data",
          "text": "-Member must log into VMPF and update address, office symbol and Duty\\n\\nPHONE:",
          "verificationRequired": false
        },
        {
          "id": 15,
          "title": "Professional Development (Officers Only)",
          "text": "-POC: Ms. Kelly Rhodes\\n-Bldg 892, Rm 140-B\\n-Phone: 416-4702/5434",
          "verificationRequired": false
        },
        {
          "id": 16,
          "title": "Voting Rep",
          "text": "-AFPEO BES: Capt Ko, Alexander\\n-Bldg 884, Rm 1400L, 416-4349\\nEmail: alexander.ko.1@us.af.mil\\n-Email or call voting POC to complete In-Processing",
          "verificationRequired": false
        },
        {
          "id": 17,
          "title": "Legal Office",
          "text": "Bldg 892, Rm 280, 416-5055\\n-Bring OGE FM 450 and Proof of Ethics Training (If required by Supervisor)",
          "verificationRequired": false
        },
        {
          "id": 18,
          "title": "Unit Training (Officer and Enlisted) Update TBA/AFTR/MilPDS/ADLS",
          "text": "-Bldg 892, Rm 150-G/H (MSgt Berrios or TSgt Sullivan)\\n-Phone: 416-4809/4223\\n-Email: AFLCMC Det 5/CCT Training (AFLCMCDet5.CCT.Training@us.af.mil\\n-Must have your AF PORTAL ID\\n-First Term Arimen must be accompanied by Supervisor\\n-New Airmen bystander intervention Training",
          "verificationRequired": false
        },
        {
          "id": 19,
          "title": "Government Travel Card",
          "text": "-AFLCMC/FM Customer Service, Bldg 892, Rm 270, 416-4385 \\n -If this is your first base, you must obtain your GTC! VISA: No, DIRECT DEPOSIT: NO",
          "verificationRequired": false
        },
        {
          "id": 20,
          "title": "Network Account Management (EITASS/CFP)",
          "text": "-AFLCMC Communications Focal Point (CFP), Bldg 889, Rm 270-1 \\n -Submit account request using AF EIT Service Portal: https://servicecenter.af.mil or call AF EIT Service Center at 888-996-1629 \\n --MILITARY and CIVILIAN personnel will provide the following information in the ticket: \\n *Please identify if you need a new account or just need account moved (provisioned) \\n *Given Name \\n *10 digit DODID#  \\n *Office Symbol and DSN \\n *Attach AF4394 and Cyber Awareness Training \\n (If ticket is submitted using the Service Portal listed above) \\n--CONTRACTOR Personnel will provide the following information in the ticket: \\n *Given Name \\n *10 digit DODID# \\n * Office Symbol and DSN \\n *Attach DD2875, AF4394, and Cyber Awareness Training \\n (if ticket is submitted using Service Portal listed above) \\n-All other inquires or questions should be directed to Comm Focal Point(CFP)\\n Email: comm.focal.point2@us.af.mil" ,
          "verificationRequired": false
        },
        {
          "id": 21,
          "title": "Security Office",
          "text": "-Bldg 892, Rom 140, 416-4820 Email: security.office@us.af.mil \\n -walkin hours: Tuesdays and Thursdays - 0900-1100 and 1300-1600 \\n-Bring Completed AF FORM 2586, Unescorded entry authorization certificate, signed by your supervisor \\n -Security Orientation/NATO Training \\n- JPAS Introduction",
          "verificationRequired": false
        },
        {
          "id": 22,
          "title": "Unit Deployment Manager",
          "text": "-Bldg 892, Rm 120 (MSgt Dodds or SSgt Juba) \\n -Phone: 416-6829/4425 \\n -Email: aflcmc.det5.udm@us.af.mil \\n -Please include your supervisor",
          "verificationRequired": false
        },
        {
          "id": 23,
          "title": "AEF Online",
          "text": "-Member must make an account and update info before going to UDM \\n- Link: https://aefonline.afpc.randolph.af.mil/default.aspx ",
          "verificationRequired": false
        },
        {
          "id": 24,
          "title": "(First Term Airmen) - L.E.A.D",
          "text": "Contact: SSgt Jean-Baptiste, Frantz, 416-4599, frantz.jean-baptiste.1@us.af.mil ",
          "verificationRequired": false
        },
        {
          "id": 25,
          "title": "(Gunter Dorm Residents) - Post Office Box",
          "text": "-Bldg 40, Maxwell AFB, 953-0299",
          "verificationRequired": false
        },
        {
          "id": 26,
          "title": "Physical Fitness Assessment",
          "text": "-UFPM is located at Det 5/CC, Bldg 892, Rm 220, 416-5546 \\n -Email a copy of most recent scores to: \\n “AFLCMC Det 5 Personnel Workflow” esc.det1.css@us.af.mil",
          "verificationRequired": false
        },
        {
          "id": 27,
          "title": "Mandatory Newcomers Privacy Briefing",
          "text": "-Bldg 888, Rm 2077, Knowledge Management Office, 416-6885 ",
          "verificationRequired": false
        },
        {
          "id": 28,
          "title": "Motorcycle Operators",
          "text": "-Contact the Unit Motorcycle Safety Rep: \\n TSgt Perkins, 416-5244 or SSgt Cheathem, 416-7311)",
          "verificationRequired": false
        },
        {
          "id": 29,
          "title": "AFPAAS",
          "text": "-Member must log into AFPAAS and update contact information \\n Link: https://afpaas.af.mil/cas/login?service=https%3A%2F%2Fafpaas.af.mil%2F",
          "verificationRequired": false
        },
        {
          "id": 30,
          "title": "Update At-hoc Information",
          "text": "-Click the purple globe and ensure your information is updated in case of an emergency",
          "verificationRequired": false
        },
        {
          "id": 31,
          "title": "Permissive TDY: (House Hunting - 10 Days)",
          "text": "-If Authorized: AFI36-3003, Table 4.5, Rule 1 ",
          "verificationRequired": false
        },
        {
          "id": 32,
          "title": "LEAVEWEB",
          "text": "-Member log onto leaveweb and register/update hierarchy to “AFLCMC” ",
          "verificationRequired": false
        }
      ]
    },
    {
      "id": 3,
      "title": "DET 5/CSS ACTIONS",
      "tasks": [
        {
          "id": 33,
          "title":"WAPS Test Date (SrA – SSgt): ",
          "text": "-If Yes, issue member’s 1566 with test date from WAPS folder ",
          "verificationRequired": false
        },
        {
          "id": 34,
          "title":"Add to In-Processing Clipboard ",
          "text": "",
          "verificationRequired": false
        },
        {
          "id": 35,
          "title":"Essential Station Messing (ESM)",
          "text": "GUNTER DORM RESIDENTS ONLY-LETTER SENT TO 42 FSS/FSVF \\n-Det 5/CSS, Bldg 892, Rm 220, 416-5546",
          "verificationRequired": false
        },
        {
          "id": 36,
          "title":"Scan All In-Processing Source Documents and File in the Members PIF",
          "text":"",
          "verificationRequired": false
        },
        {
          "id": 37,
          "title":"If PCAing from Maxwell AFB, Collect AF FORM 2096 from Losing Unit",
          "text":"",
          "verificationRequired": false
        },
        {
          "id": 38,
          "title":"AEF Assignment",
          "text":"-Refer to Inbound Sponsor & Duty Information Worksheet. If it’s not listed, contact members Division Superintendent. \\nAEF # X- (Must be complete before visiting the Unit Deployment Manager (UDM)",
          "verificationRequired": false
        }
      ]
    }
  ]
}'''));
}

/// events!
abstract class ChecklistEvent {}
class ChecklistRequested extends ChecklistEvent {
  final String checklistID;

  ChecklistRequested({this.checklistID});
}

/// states!
abstract class ChecklistState extends Equatable {
  @override
  List<Object> get props => [];
}
class ChecklistInitial extends ChecklistState {}
class ChecklistLoadInProgress extends ChecklistState {}
class ChecklistLoadSuccess extends ChecklistState {
  final Checklist checklist;

  ChecklistLoadSuccess(this.checklist);

  @override
  List<Object> get props => [checklist];
}
class ChecklistLoadFailure extends ChecklistState {
  final Exception error;

  ChecklistLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}

/// mapping events to states!
class ChecklistBloc extends Bloc<ChecklistEvent, ChecklistState> {
  final ChecklistRepository _repository;

  ChecklistBloc([ChecklistRepository repository])
    : assert (repository != null),
      this._repository = repository,
      super(ChecklistInitial());

  @override
  Stream<ChecklistState> mapEventToState(ChecklistEvent event) async* {
    if (event is ChecklistRequested) {
      yield ChecklistLoadInProgress();
      try {
        Checklist checklist = await _repository.getChecklist("1");
        yield ChecklistLoadSuccess(checklist);
      } catch (error) {
        yield ChecklistLoadFailure(error);
      }
    }
  }

  @override
  void onChange(Change<ChecklistState> change) {
    print("checklistBloc change: $change");
    super.onChange(change);
  }
}