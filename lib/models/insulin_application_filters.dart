class InsulinApplicationFilters {
  DateTime? minDate;
  DateTime? maxDate;
  int? minUnits;
  int? maxUnits;
  int? minGlucose;
  int? maxGlucose;

  InsulinApplicationFilters({
    this.minDate,
    this.maxDate,
    this.minUnits,
    this.maxUnits,
    this.minGlucose,
    this.maxGlucose,
  });

  InsulinApplicationFilters.fromJson(Map<String, dynamic> json) {
    minDate =
        json['min_date'] != null ? DateTime.parse(json['min_date']) : null;
    maxDate =
        json['max_date'] != null ? DateTime.parse(json['max_date']) : null;
    minUnits = json['min_units'];
    maxUnits = json['max_units'];
    minGlucose = json['min_glucose'];
    maxGlucose = json['max_glucose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (minDate != null) {
      data['min_date'] = minDate!.toIso8601String();
    }
    if (maxDate != null) {
      data['max_date'] = maxDate!.toIso8601String();
    }
    if (minUnits != null) {
      data['min_units'] = minUnits;
    }
    if (maxUnits != null) {
      data['max_units'] = maxUnits;
    }
    if (minGlucose != null) {
      data['min_glucose'] = minGlucose;
    }
    if (maxGlucose != null) {
      data['max_glucose'] = maxGlucose;
    }
    return data;
  }
}
