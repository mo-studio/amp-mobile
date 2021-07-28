// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:AMP/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

final checklist = Checklist.fromJson(jsonDecode('''{
    "title": "Test In-Processing Checklist",
    "subtitle": "This is a test checklist.",
    "description": "This is a description.",
    "categories": [
      {
        "title": "Sponsor Actions",
        "tasks": [
          {
            "title": "Email DET 5/CSS with Newcomer's Orders",
            "text": "Send/Email to AFLCMC Det 5 Personnel Workflow"
          },
          {
            "title": "Email DET 5/CSS current AFFMS II Fitness Report",
            "text": "Send/Email to AFLCMC Det 5 Personnel Workflow"
          },
          {
            "title": "Email DET 5/CSS Member's ROM LILO",
            "text": "Send copy of ROM (Letter In Liue Of) from member's loosing MPF"
          }
        ]
      },{
        "title": "Newcomer's Appointments",
        "tasks": [
          {
            "title": "FOR FINANCE",
            "text": "-Receipts (TLE/Non-Availability/Airline Tickets…etc) \\n -BAH Waiver’s \\n -ROM Letter "
          },
          {
            "title": "IF FIRST TERM AIRMAN (FTA)",
            "text": "-BMT Certificate \\n -Tech School Certificate \\n -DD4 Enlistment Document"
          },
          {
            "title": "FOR THE MPS",
            "text": "-ROM Letter \\n-Completed IDA Worksheet \\n-Endorsed/Signed Orders \\n-AF Form 330 Records Transmittal \\n-PT Score Card \\n-Sealed Packet/Envelope from last duty station \\n-5 Copies of orders and amendments \\n-Marriage/Birth Certificate (Only if member was married, divorced, had child…etc "
          },
          {
            "title": "42nd MPS & FINANCE IN-PROCESSING",
            "text": "-Maxwell AFB, Bldg 804, Customer Service Lobby. Every Monday and Wednesday @ 0900 \\n-Member’s must hand carry the below source documents received from the Det 5/CSS to this appointment."
          },
          {
            "title": "RIGHT START - ALL AIRMEN",
            "text": "-Please sign up by calling or emailing Ms. Rebecca Hackett \\nPhone: 953-3791 \\nEmail: rebecca.hackett.2@us.af.mil \\n-Newcomer’s Right Start Orientation sign in begins at 0730 at the Maxwell Club, Bldg 144. Please be in place by 0745. Please do not bring food or beverages into the facility. Right Start is mandatory and should be completed within 30 days of in-processing. Medical Right Start is for Active Duty Military only and will begin at 1330 at the Maxwell Clinic, Bldg 760 (3rd Floor Classroom). Please bring a copy of your orders. Spouses are invited to attend 0730-1230. "
          },
          {
            "title": "FIRST TERM AIRMAN CENTER (FTAC): FIRST DUTY STATION AIRMEN ONLY",
            "text": "-Please sign up at: https://cs3.eis.af.mil/site/er/0291/SitePages/Home.aspx \\n-Location: Bldg 501, Rm 112, report time is 0730. \\n-Description: This is an introductory course for all First Term Airman arriving at Maxwell/Gunter as their first duty station. This course is mandated by the Air Force. ABU’s/OCP’s are the UOD."
          },
          {
            "title": "SCHEDULE BES/SUPT ONE-ON-ONE BRIEF",
            "text": "-Sponsor email the Chief's Exec: SrA McCash, Courtney: courtney.mccash@us.af.mil"
          },
          {
            "title": "SCHEDULE DET 5/FIRST SERGEANT ONE-ON-ONE BRIEF",
            "text": "-Sponsor email the CC Exec at “Gunter AFLCMC Det5/CC Workflow” esc.det1.cc@us.af.mil"
          },
          {
            "title": "SCHEDULE DET 5/COMMANDER ONE-ON-ONE BRIEF",
            "text": "-Sponsor email the CC Exec at “Gunter AFLCMC Det5/CC Workflow” esc.det1.cc@us.af.mil"
          }
        ]
      },{
        "title": "Member's Actions",
        "tasks":[
            {
                "title": "REPORT TO YOUR DIVISION ADMIN FOR INTERNAL IN-PROCESSING PROCEDURES",
                "text": ""
              },
              {
                "title": "RECALL ROSTER CONTACT INFORMATION",
                "text": "-In your duty Section"
              },
              {
                "title": "VIRTUAL RECORD OF EMERGENCY DATA",
                "text": "-Member must log into VMPF and update address, office symbol and Duty\\n\\nPHONE:"
              },
              {
                "title": "PROFESSIONAL DEVELOPMENT (Officers Only)",
                "text": "-POC: Ms. Kelly Rhodes\\n-Bldg 892, Rm 140-B\\n-Phone: 416-4702/5434"
              },
              {
                "title": "VOTING REP",
                "text": "-AFPEO BES: Capt Ko, Alexander\\n-Bldg 884, Rm 1400L, 416-4349\\nEmail: alexander.ko.1@us.af.mil\\n-Email or call voting POC to complete In-Processing"
              },
              {
                "title": "LEGAL OFFICE",
                "text": "Bldg 892, Rm 280, 416-5055\\n-Bring OGE FM 450 and Proof of Ethics Training (If required by Supervisor)"
              },
              {
                "title": "UNIT TRAINING (Officer and Enlisted) UPDATE TBA/AFTR/MilPDS/ADLS",
                "text": "-Bldg 892, Rm 150-G/H (MSgt Berrios or TSgt Sullivan)\\n-Phone: 416-4809/4223\\n-Email: AFLCMC Det 5/CCT Training (AFLCMCDet5.CCT.Training@us.af.mil\\n-Must have your AF PORTAL ID\\n-First Term Arimen must be accompanied by Supervisor\\n-New Airmen bystander intervention Training"
              },
              {
                "title": "GOVERNMENT TRAVEL CARD",
                "text": "-AFLCMC/FM Customer Service, Bldg 892, Rm 270, 416-4385 \\n -If this is your first base, you must obtain your GTC! VISA: No, DIRECT DEPOSIT: NO"
              },
              {
                "title": "NETWORK ACCOUNT MANAGEMENT (EITASS/CFP)",
                "text": "-AFLCMC Communications Focal Point (CFP), Bldg 889, Rm 270-1 \\n -Submit account request using AF EIT Service Portal: https://servicecenter.af.mil or call AF EIT Service Center at 888-996-1629 \\n --MILITARY and CIVILIAN personnel will provide the following information in the ticket: \\n *Please identify if you need a new account or just need account moved (provisioned) \\n *Given Name \\n *10 digit DODID#  \\n *Office Symbol and DSN \\n *Attach AF4394 and Cyber Awareness Training \\n (If ticket is submitted using the Service Portal listed above) \\n--CONTRACTOR Personnel will provide the following information in the ticket: \\n *Given Name \\n *10 digit DODID# \\n * Office Symbol and DSN \\n *Attach DD2875, AF4394, and Cyber Awareness Training \\n (if ticket is submitted using Service Portal listed above) \\n-All other inquires or questions should be directed to Comm Focal Point(CFP)\\n Email: comm.focal.point2@us.af.mil" 
              },
              {
                "title": "SECURITY OFFICE",
                "text": "-Bldg 892, Rom 140, 416-4820 Email: security.office@us.af.mil \\n -walkin hours: Tuesdays and Thursdays - 0900-1100 and 1300-1600 \\n-Bring Completed AF FORM 2586, Unescorded entry authorization certificate, signed by your supervisor \\n -Security Orientation/NATO Training \\n- JPAS Introduction"
              },
              {
                "title": "UNIT DEPLOYMENT MANAGER",
                "text": "-Bldg 892, Rm 120 (MSgt Dodds or SSgt Juba) \\n -Phone: 416-6829/4425 \\n -Email: aflcmc.det5.udm@us.af.mil \\n -Please include your supervisor"
              },
              {
                "title": "AEF ONLINE",
                "text": "-Member must make an account and update info before going to UDM \\n- Link: https://aefonline.afpc.randolph.af.mil/default.aspx "
              },
              {
                "title": "(FIRST TERM AIRMEN) - L.E.A.D",
                "text": "Contact: SSgt Jean-Baptiste, Frantz, 416-4599, frantz.jean-baptiste.1@us.af.mil "
              },
              {
                "title": "(GUNTER DORM RESIDENTS) - POST OFFICE BOX",
                "text": "-Bldg 40, Maxwell AFB, 953-0299"
              },
              {
                "title": "PHYSICAL FITNESS ASSESSMENT",
                "text": "-UFPM is located at Det 5/CC, Bldg 892, Rm 220, 416-5546 \\n -Email a copy of most recent scores to: \\n “AFLCMC Det 5 Personnel Workflow” esc.det1.css@us.af.mil"
              },
              {
                "title": "MANDATORY NEWCOMERS PRIVACY BRIEFING",
                "text": "-Bldg 888, Rm 2077, Knowledge Management Office, 416-6885 "
              },
              {
                "title": "MOTOR CYCLE OPERATORS",
                "text": "-Contact the Unit Motorcycle Safety Rep: \\n TSgt Perkins, 416-5244 or SSgt Cheathem, 416-7311)"
              },
              {
                "title": "AFPAAS",
                "text": "-Member must log into AFPAAS and update contact information \\n Link: https://afpaas.af.mil/cas/login?service=https%3A%2F%2Fafpaas.af.mil%2F"
              },
              {
                "title": "UPDATE AT-HOC INFORMATION",
                "text": "-Click the purple globe and ensure your information is updated in case of an emergency"
              },
              {
                "title": "PERMISSIVE TDY: (House Hunting - 10 Days)",
                "text": "-If Authorized: AFI36-3003, Table 4.5, Rule 1 "
              },
              {
                "title": "LEAVEWEB",
                "text": "-Member log onto leaveweb and register/update hierarchy to “AFLCMC” "
              }
        ]
      },{
        "title": "DET 5/CSS ACTIONS",
        "tasks":[
            {
                "title":"WAPS TEST DATE (SrA – SSgt): ",
                "text": "-If Yes, issue member’s 1566 with test date from WAPS folder "
            },{
                "title":"ADD TO IN-PROCESSING CLIPBOARD ",
                "text": ""
            },{
                "title":"ESSENTIAL STATION MESSING (ESM)",
                "text": "GUNTER DORM RESIDENTS ONLY-LETTER SENT TO 42 FSS/FSVF \\n-Det 5/CSS, Bldg 892, Rm 220, 416-5546"
            },{
                "title":"SCAN ALL IN-PROCESSING SOURCE DOCUMENTS AND FILE IN THE MEMBERS PIF",
                "text":""
            },{
                "title":"IF PCA’ING FROM MAXWELL AFB, COLLECT AF FORM 2096 FROM LOSING UNIT",
                "text":""
            },{
                "title":"AEF ASSIGNMENT",
                "text":"-Refer to Inbound Sponsor & Duty Information Worksheet. If it’s not listed, contact members Division Superintendent. \\nAEF # X- (Must be complete before visiting the Unit Deployment Manager (UDM)"
            }
        ]
      }
    ]
  }'''));

final emptyChecklist = Checklist.fromJson(jsonDecode(
    '{"title": "","subtitle": "","description": "","categories": []}'));

void main() {
  group('Checklist', () {

    test('has categories', () {
      expect(checklist.categories.length, isNot(0));
    });

    test('category has a title', () {
      expect(checklist.categories[0].title, isNot(null));
    });

    test('category has tasks', () {
      expect(checklist.categories[0].tasks.length, isNot(0));
    });

    test('task has a title', () {
      expect(checklist.categories[0].tasks[0].title, isNot(null));
    });

    test('task has text', () {
      expect(checklist.categories[0].tasks[0].text, isNot(null));
    });
  });

  group('Empty Checklist', () {

    test('has no categories', () {
      expect(emptyChecklist.categories.length, equals(0));
    });
  });

  // group('Task', () {
  //   final task = checklist.categories[0].tasks[0];
  //   test('original status is notStarted', () {
  //     expect(task.status, equals(Status.notStarted));
  //     expect(task.status.color, equals(Colors.red));
  //   });

  //   test('can change status to inProgress', () {
  //     task.status = Status.inProgress;
  //     expect(task.status, equals(Status.inProgress));
  //     expect(task.status.color, equals(Colors.orange));
  //   });

  //   test('can change status to complete', () {
  //     task.status = Status.complete;
  //     expect(task.status, equals(Status.complete));
  //     expect(task.status.color, equals(Colors.green));
  //   });
  // });
}
