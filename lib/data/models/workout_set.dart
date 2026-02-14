class WorkoutSet {
  final int reps;
  final int weight;
  final int? dropSetReps;
  final int? dropSetWeight;
  final bool hasDropSet;

  WorkoutSet({
    required this.reps,
    required this.weight,
    required this.dropSetReps,
    required this.dropSetWeight,
  }) : hasDropSet = dropSetReps != null && dropSetWeight != null;

  factory WorkoutSet.fromJson(Map<String, dynamic> json) => WorkoutSet(
    reps: json['reps'],
    weight: json['weight'],
    dropSetReps: json['drop_set_reps'],
    dropSetWeight: json['drop_set_weight'],
  );

  Map<String, dynamic> toJson() => {
    "reps": reps,
    "weight": weight,
    "drop_set_reps": dropSetReps,
    "drop_set_weight": dropSetWeight,
  };

  String get repsData => "$reps x $weight";

  String get dropSetRepsData => "$dropSetReps x $dropSetWeight";
}
