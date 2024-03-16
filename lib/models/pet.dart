import 'package:diapets_mobile/models/user.dart';

class Pet {
  int? id;
  String? name;
  String? species;
  String? birthdate;
  List<User> owners;

  Pet(
      {this.id,
      this.name,
      this.species,
      this.birthdate,
      this.owners = const []});

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      name: json['name'],
      species: json['species'],
      birthdate: json['birthdate'],
      owners:
          json['owners'].map<User>((owner) => User.fromJson(owner)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'birthdate': birthdate,
      'owners': owners.map((owner) => owner.toJson()).toList(),
    };
  }
}
