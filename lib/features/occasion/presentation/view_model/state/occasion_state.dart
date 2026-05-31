import 'package:equatable/equatable.dart';
import 'package:flower_app/features/occasion/domain/entities/occasion_entity.dart';

enum OccasionStatus { initial, loading, success, failure }

class OccasionState extends Equatable {
  final OccasionStatus status;
  final List<OccasionEntity> occasions;
  final int selectedTabIndex;
  final String? errorMessage;

  const OccasionState({
    this.status = OccasionStatus.initial,
    this.occasions = const [],
    this.selectedTabIndex = 0,
    this.errorMessage,
  });

  OccasionState copyWith({
    OccasionStatus? status,
    List<OccasionEntity>? occasions,
    int? selectedTabIndex,
    String? errorMessage,
  }) {
    return OccasionState(
      status: status ?? this.status,
      occasions: occasions ?? this.occasions,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    occasions,
    selectedTabIndex,
    errorMessage,
  ];
}
