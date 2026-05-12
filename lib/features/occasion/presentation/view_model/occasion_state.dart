import 'package:equatable/equatable.dart';
import 'package:flower_app/features/occasion/data/models/occasion_dto.dart';

sealed class OccasionState extends Equatable {
  const OccasionState();

  @override
  List<Object?> get props => [];
}

class OccasionInitial extends OccasionState {
  const OccasionInitial();
}

class OccasionLoading extends OccasionState {
  const OccasionLoading();
}

class OccasionSuccess extends OccasionState {
  final List<OccasionDTO> occasions;
  final int selectedTabIndex;

  const OccasionSuccess({
    required this.occasions,
    this.selectedTabIndex = 0,
  });

  OccasionSuccess copyWith({
    List<OccasionDTO>? occasions,
    int? selectedTabIndex,
  }) {
    return OccasionSuccess(
      occasions: occasions ?? this.occasions,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }

  @override
  List<Object?> get props => [occasions, selectedTabIndex];
}

class OccasionFailure extends OccasionState {
  final String errorMessage;

  const OccasionFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
