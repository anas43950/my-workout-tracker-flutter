class WorkoutHistorySet {
  final int reps;
  final int weight;
  final int? dropSetReps;
  final int? dropSetWeight;

  WorkoutHistorySet({
    required this.reps,
    required this.weight,
    required this.dropSetReps,
    required this.dropSetWeight,
  });

  factory WorkoutHistorySet.fromJson(Map<String, dynamic> json) => WorkoutHistorySet(
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
}
