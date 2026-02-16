import 'package:workout_tracker/utils/extensions.dart';

class WorkoutSet {
  final int reps;
  final double weight;
  final int? dropSetReps;
  final double? dropSetWeight;
  final bool hasDropSet;

  WorkoutSet({
    required this.reps,
    required this.weight,
    required this.dropSetReps,
    required this.dropSetWeight,
  }) : hasDropSet = dropSetReps != null && dropSetWeight != null;

  factory WorkoutSet.fromJson(Map<String, dynamic> json) => WorkoutSet(
    reps: json['reps'],
    weight: json['weight'].toDouble(),
    dropSetReps: json['drop_set_reps'],
    dropSetWeight: json['drop_set_weight']?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "reps": reps,
    "weight": weight,
    if (dropSetReps != null) "drop_set_reps": dropSetReps,
    if (dropSetReps != null) "drop_set_weight": dropSetWeight,
  };

  String get repsData => "${weight.formatToString} x $reps";

  String get dropSetRepsData => "${dropSetWeight?.formatToString} x $dropSetReps";
}
