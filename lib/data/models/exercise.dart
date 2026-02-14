class Exercise {
  final int id;
  final String name;
  final int sets;
  final int repRangeFrom;
  final int repRangeTo;
  final bool hasFixedReps;

  Exercise({
    required this.id,
    required this.name,
    required this.sets,
    required this.repRangeFrom,
    required this.repRangeTo,
  }) : hasFixedReps = repRangeFrom == repRangeTo;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    id: json['id'],
    name: json['name'],
    sets: json['sets'],
    repRangeFrom: json['rep_range_from'],
    repRangeTo: json['rep_range_to'],
  );

  Map<String, dynamic> toJson({bool includeId = false}) => {
    if (includeId) 'id': id,
    'name': name,
    'sets': sets,
    'rep_range_from': repRangeFrom,
    'rep_range_to': repRangeTo,
  };

  String get _reps => hasFixedReps ? "$repRangeFrom" : "$repRangeFrom-$repRangeTo";

  String get setsData => "$sets x $_reps";
}
