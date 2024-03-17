import 'package:diapets_mobile/models/user.dart';

class InsulinApplication {
  int? id;
  int? glucoseLevel;
  int? insulinUnits;
  DateTime? applicationTime;
  String? observations;
  User? user;

  InsulinApplication({
    this.id,
    this.glucoseLevel,
    this.insulinUnits,
    this.applicationTime,
    this.observations,
    this.user,
  });

  factory InsulinApplication.fromJson(Map<String, dynamic> json) {
    return InsulinApplication(
      id: json['id'],
      glucoseLevel: json['glucose_level'],
      insulinUnits: json['insulin_units'],
      applicationTime: DateTime.parse(json['application_time']).toLocal(),
      observations: json['observations'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'glucose_level': glucoseLevel,
      'insulin_units': insulinUnits,
      'application_time': applicationTime?.toUtc().toIso8601String(),
      'observations': observations,
      'user': user?.toJson(),
    };
  }
}
