import 'package:gartenjeden/models/plant_type.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/event.dart';
import '../models/settings.dart';
import '../models/plant.dart';
import '../models/diary_entry.dart';

import '../constants/config.dart';

class ApiService {
  final storage = const FlutterSecureStorage();

  Future<dynamic> fetchEvents() async {
    final uri = Uri.parse(baseUrl + "/events");
    final token = await getToken();
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    };

    try {
      var response = await http.get(
        uri, 
        headers: headers
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        var events = <Event>[];
        var jsonEvents = jsonDecode(response.body);
        for(var i = 0; i < jsonEvents['events'].length; i++) {
          events.add(Event.fromJson(jsonEvents['events'][i]));
        }

        return events;
      }
    } catch(err) {
      print(err);
      return null;
    }
  }

  Future<dynamic> saveSettings(settings) async {
    final uri = Uri.parse(baseUrl + "/settings");
    final token = await getToken();
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    };
    Map<String, dynamic> body = {
      "pourNotifications": settings.pourNotifications,
      "fertilizeNotifications": settings.fertilizeNotifications,
      "mondayNotifications": settings.mondayNotifications,
      "tuesdayNotifications": settings.tuesdayNotifications,
      "wednesdayNotifications": settings.wednesdayNotifications,
      "thursdayNotifications": settings.thursdayNotifications,
      "fridayNotifications": settings.fridayNotifications,
      "saturdayNotifications": settings.saturdayNotifications,
      "sundayNotifications": settings.sundayNotifications,
      "remindDaily": settings.remindDaily,
      "remindWeekly": settings.remindWeekly
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    try {
      var response = await http.put(
        uri, 
        headers: headers,
        body: jsonBody,
        encoding: encoding
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        return null;
      }
    } catch(err) {
      print(err);
      return null;
    }
  }

  Future<dynamic> fetchSettings() async {
    final uri = Uri.parse(baseUrl + "/settings");
    final token = await getToken();
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    };

    try {
      var response = await http.get(
        uri, 
        headers: headers
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        return Settings.fromJson(jsonDecode(response.body));
      }
    } catch(err) {
      print(err);
      return null;
    }
  }
  
  Future<dynamic> deletePlant(Plant plant) async {
    final uri = Uri.parse(baseUrl + "/plants/" + plant.id.toString());
    final token = await getToken();
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    };

    try {
      var response = await http.delete(
        uri, 
        headers: headers
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
    } catch(err) {
      print(err);
      return false;
    }
  }

  Future<dynamic> fetchPlants() async {
    final uri = Uri.parse(baseUrl + "/plants");
    final token = await getToken();
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    };

    try {
      var response = await http.get(
        uri, 
        headers: headers
      );

      var json = await jsonDecode(response.body);
      var plants = [];

      for(var i = 0; i < json.length; i++) {
        plants.add(Plant.fromJson(json[i]));
      }
      
      return plants;
    } catch(err) {
      print(err);
      return null;
    }
  }

  Future<int> measureRequestTime() async {
    final uri = Uri.parse(baseUrl + "/plants");
    final token = await getToken();
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    };

    try {
      var startTime = DateTime.now().millisecondsSinceEpoch;
      var response = await http.get(
        uri, 
        headers: headers
      );
      var endTime = DateTime.now().millisecondsSinceEpoch;
      
      return endTime - startTime;
    } catch(err) {
      print(err);
      return 0;
    }
  }

  Future<dynamic> saveDiaryEntry(int plantId, int plantHeight) async {
    final uri = Uri.parse(baseUrl + "/" + plantId.toString() + "/diary-entries");
    final token = await getToken();
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    };
    Map<String, dynamic> body = {
      "plantHeight": plantHeight
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    try {
      var response = await http.post(
        uri, 
        headers: headers,
        body: jsonBody,
        encoding: encoding
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
    } catch(err) {
      print(err);
      return false;
    }
  }

  Future<dynamic> fetchDiaryEntries(int plantId) async {
    final uri = Uri.parse(baseUrl + "/" + plantId.toString() + "/diary-entries");
    final token = await getToken();
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    };

    try {
      var response = await http.get(
        uri, 
        headers: headers
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        var json = jsonDecode(response.body);
        List<DiaryEntry> diaryEntries = [];

        for(var i = 0; i < json['diaryEntries'].length; i++) {
          diaryEntries.add(DiaryEntry.fromJson(json['diaryEntries'][i]));
        }

        return diaryEntries;
      }
    } catch(err) {
      print(err);
      return null;
    }
  }

  Future<dynamic> fetchAllPlantTypes() async {
    final uri = Uri.parse(baseUrl + "/plant-types");
    final token = await getToken();
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    };

    try {
      var response = await http.get(
        uri, 
        headers: headers
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        return null;
      }
    } catch(err) {
      print(err);
      return null;
    }
  }

  Future<dynamic> fetchPlantTypesByName(String name) async {
    final uri = Uri.parse(baseUrl + "/plant-types?nameString="+name);
    final token = await getToken();
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    };

    try {
      var response = await http.get(
        uri, 
        headers: headers
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        var plantTypes = [];
        var json = jsonDecode(response.body);
        json.forEach((plantType) {
          plantTypes.add(PlantType.fromJson(plantType));
        });

        return plantTypes;
      }
    } catch(err) {
      print(err);
      return null;
    }
  }

  Future<dynamic> savePlant(String plantName, String plantType, int plantHeight, int plantTypeId, String image) async {
    final uri = Uri.parse(baseUrl + "/plants");
    final token = await getToken();
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    };
    Map<String, dynamic> body = {
      "name": plantName,
      "type": plantType,
      "height": plantHeight,
      "typeId": plantTypeId,
      "image": image
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    try {
      var response = await http.post(
        uri, 
        headers: headers,
        body: jsonBody,
        encoding: encoding
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
    } catch(err) {
      print(err);
      return false;
    }
  }

  getToken() async {
    var token = await storage.read(key: "token");
    return token;
  }
}