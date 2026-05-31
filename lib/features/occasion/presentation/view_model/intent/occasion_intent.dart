import 'package:equatable/equatable.dart';

sealed class OccasionIntent extends Equatable {
  const OccasionIntent();

  @override
  List<Object?> get props => [];
}

class LoadOccasionsIntent extends OccasionIntent {
  final int initialIndex;

  const LoadOccasionsIntent({this.initialIndex = 0});

  @override
  List<Object?> get props => [initialIndex];
}

class SelectTabIntent extends OccasionIntent {
  final int index;

  const SelectTabIntent(this.index);

  @override
  List<Object?> get props => [index];
}
