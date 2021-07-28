import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'dart:convert';
import 'package:AMP/models/model.dart';

enum Environment { local, develop }

extension EnvironmentURL on Environment {
  String get url {
    switch (this) {
      case Environment.local: return "http://localhost:3000/api/v1/";
      case Environment.develop: return "https://api-amp.dev.amp.teambespin.us/api/v1/";
    }
  }

  String get authURL {
    switch (this) {
      case Environment.local: return "http://keycloak:8080/";
      case Environment.develop: return "https://auth-amp.dev.amp.teambespin.us/";
    }
  }
}

class API {
  static final env = Environment.develop;

  static http.Client client = IOClient();

  static String accessToken = '';
  static String refreshToken = '';

  static int userID = 3;

  static Future<Checklist> getChecklist() async {
    final url = Uri.parse(env.url + "checklist/$userID");
    final res = await client.get(url, headers: {"Content-Type": "application/json", "Authorization": "Bearer $accessToken"});
    if (res.statusCode == 200) {
      return Checklist.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to fetch checklist');
    }
  }

  static Future<ChecklistProgress> getChecklistProgress() async {
    final url = Uri.parse(env.url + "progress/$userID");
    final res = await client.get(url, headers: {"Content-Type": "application/json", "Authorization": "Bearer $accessToken"});
    if (res.statusCode == 200) {
      return ChecklistProgress.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to fetch checklist progress');
    }
  }

  static Future<ChecklistProgress> putChecklistProgress(int taskID, Status status) async {
    final url = Uri.parse(env.url + "progress/$userID");
    final res = await client.put(url,
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $accessToken"},
        body: jsonEncode(TaskStatus(taskID, status)));
    if (res.statusCode == 200) {
      return ChecklistProgress.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to update checklist progress');
    }
  }
}
