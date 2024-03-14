class Pet {
  int? id;
  String? name;
  String? species;
  String? birthdate;

  Pet({this.id, this.name, this.species, this.birthdate});

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      name: json['name'],
      species: json['species'],
      birthdate: json['birthdate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'birthdate': birthdate,
    };
  }
}
