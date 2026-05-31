import 'dart:async';

import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/occasion/domain/entities/occasion_entity.dart';
import 'package:flower_app/features/occasion/domain/entities/occasions_response_entity.dart';
import 'package:flower_app/features/occasion/domain/repositories/occasion_repo_contract.dart';
import 'package:flower_app/features/occasion/domain/use_cases/get_occasions_use_case.dart';
import 'package:flower_app/features/occasion/presentation/view_model/cubit/occasion_cubit.dart';
import 'package:flower_app/features/occasion/presentation/view_model/intent/occasion_intent.dart';
import 'package:flower_app/features/occasion/presentation/view_model/state/occasion_state.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Fake repository — lets tests control what getOccasions() returns.
// ---------------------------------------------------------------------------
class _FakeOccasionRepo implements OccasionRepoContract {
  BaseResponse<OccasionsResponseEntity>? response;
  Completer<BaseResponse<OccasionsResponseEntity>>? completer;
  int callsCount = 0;

  @override
  Future<BaseResponse<OccasionsResponseEntity>> getOccasions() {
    callsCount++;
    final c = completer;
    if (c != null) return c.future;
    return Future.value(response);
  }
}

// ---------------------------------------------------------------------------
// Helper — builds an entity list with the given names.
// ---------------------------------------------------------------------------
List<OccasionEntity> _makeOccasions(List<String> names) {
  return names
      .map(
        (n) => OccasionEntity(
          id: n,
          name: n,
          slug: n.toLowerCase(),
          image: 'https://img/$n.jpg',
        ),
      )
      .toList();
}

void main() {
  group('OccasionCubit', () {
    late _FakeOccasionRepo repo;
    late OccasionCubit cubit;

    setUp(() {
      repo = _FakeOccasionRepo();
      cubit = OccasionCubit(GetOccasionsUseCase(repo));
    });

    tearDown(() async {
      await cubit.close();
    });

    // -----------------------------------------------------------------------
    // Initial state
    // Verifies the cubit starts with OccasionStatus.initial before any action.
    // -----------------------------------------------------------------------
    test('starts with OccasionState with initial status', () {
      expect(cubit.state.status, OccasionStatus.initial);
    });

    // -----------------------------------------------------------------------
    // Loading → Success
    // Verifies the cubit emits [OccasionLoading, OccasionSuccess] in order
    // and that the success state holds the correctly mapped entity list.
    // -----------------------------------------------------------------------
    test(
      'emits [OccasionStatus.loading, OccasionStatus.success] on successful fetch',
      () async {
        // Arrange
        final occasions = _makeOccasions(['Birthday', 'Wedding']);
        repo.response = SuccessBaseResponse(
          data: OccasionsResponseEntity(message: 'ok', occasions: occasions),
        );
        final emitted = <OccasionState>[];
        final sub = cubit.stream.listen(emitted.add);

        // Act
        cubit.handleIntent(const LoadOccasionsIntent());
        await Future<void>.delayed(Duration.zero);
        await sub.cancel();

        // Assert
        expect(emitted, hasLength(2));
        expect(emitted[0].status, OccasionStatus.loading);
        expect(emitted[1].status, OccasionStatus.success);

        final success = emitted[1];
        expect(success.occasions, hasLength(2));
        expect(success.occasions[0].name, 'Birthday');
        expect(success.occasions[1].name, 'Wedding');
        expect(success.selectedTabIndex, 0); // default tab
      },
    );

    // -----------------------------------------------------------------------
    // Loading → Success with empty list
    // Validates that when the API returns an empty occasions array the cubit
    // still emits OccasionStatus.success (not a failure) with an empty list.
    // -----------------------------------------------------------------------
    test(
      'emits OccasionStatus.success with empty list when occasions are empty',
      () async {
        // Arrange
        repo.response = SuccessBaseResponse(
          data: OccasionsResponseEntity(message: 'ok', occasions: []),
        );
        final emitted = <OccasionState>[];
        final sub = cubit.stream.listen(emitted.add);

        // Act
        cubit.handleIntent(const LoadOccasionsIntent());
        await Future<void>.delayed(Duration.zero);
        await sub.cancel();

        // Assert
        expect(emitted[1].status, OccasionStatus.success);
        expect(emitted[1].occasions, isEmpty);
      },
    );

    // -----------------------------------------------------------------------
    // Loading → Success — null occasions falls back to empty list
    // Validates that the null-coalescing fallback in the cubit (`?? []`)
    // prevents a null reference and still emits a valid OccasionStatus.success.
    // -----------------------------------------------------------------------
    test('falls back to empty list when occasions field is null', () async {
      // Arrange — occasions field is null on the response entity
      repo.response = SuccessBaseResponse(
        data: OccasionsResponseEntity(message: 'ok', occasions: null),
      );
      final emitted = <OccasionState>[];
      final sub = cubit.stream.listen(emitted.add);

      // Act
      cubit.handleIntent(const LoadOccasionsIntent());
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      // Assert
      expect(emitted[1].status, OccasionStatus.success);
      expect(emitted[1].occasions, isEmpty);
    });

    // -----------------------------------------------------------------------
    // Loading → Failure
    // Verifies the cubit emits [OccasionStatus.loading, OccasionStatus.failure] in order
    // and that the failure state carries the error message returned by the
    // repository.
    // -----------------------------------------------------------------------
    test(
      'emits [OccasionStatus.loading, OccasionStatus.failure] on error response',
      () async {
        // Arrange
        repo.response = ErrorBaseResponse(
          errorMessage: 'Something went wrong, please try again later',
        );
        final emitted = <OccasionState>[];
        final sub = cubit.stream.listen(emitted.add);

        // Act
        cubit.handleIntent(const LoadOccasionsIntent());
        await Future<void>.delayed(Duration.zero);
        await sub.cancel();

        // Assert
        expect(emitted, hasLength(2));
        expect(emitted[0].status, OccasionStatus.loading);
        expect(emitted[1].status, OccasionStatus.failure);

        final failure = emitted[1];
        expect(
          failure.errorMessage,
          'Something went wrong, please try again later',
        );
      },
    );

    // -----------------------------------------------------------------------
    // Idempotency while loading
    // Verifies that a second call to LoadOccasionsIntent while the first is still
    // in-flight is ignored — the repository is called exactly once.
    // -----------------------------------------------------------------------
    test(
      'ignores concurrent LoadOccasionsIntent calls while already loading',
      () async {
        // Arrange — hold the future so we can control when it resolves
        repo.completer = Completer<BaseResponse<OccasionsResponseEntity>>();

        // Act — fire first call (in-flight) then immediately fire a second
        cubit.handleIntent(const LoadOccasionsIntent());
        await Future<void>.delayed(Duration.zero); // let cubit emit Loading

        cubit.handleIntent(const LoadOccasionsIntent()); // must be a no-op
        await Future<void>.delayed(Duration.zero);

        // Resolve the first call
        repo.completer!.complete(
          SuccessBaseResponse(
            data: OccasionsResponseEntity(
              message: 'ok',
              occasions: _makeOccasions(['Eid']),
            ),
          ),
        );
        await Future<void>.delayed(Duration.zero);

        // Assert — repository was hit only once
        expect(repo.callsCount, 1);
      },
    );

    // -----------------------------------------------------------------------
    // selectTab
    // Verifies that SelectTabIntent emits a new state with the updated
    // selectedTabIndex and that the occasions list remains unchanged.
    // -----------------------------------------------------------------------
    test(
      'SelectTabIntent updates selectedTabIndex inside OccasionStatus.success state',
      () async {
        // Arrange — put cubit into success state first
        final occasions = _makeOccasions(['Christmas']);
        repo.response = SuccessBaseResponse(
          data: OccasionsResponseEntity(message: 'ok', occasions: occasions),
        );
        cubit.handleIntent(const LoadOccasionsIntent());
        await Future<void>.delayed(Duration.zero);

        final emitted = <OccasionState>[];
        final sub = cubit.stream.listen(emitted.add);

        // Act
        cubit.handleIntent(const SelectTabIntent(2));
        await Future<void>.delayed(Duration.zero);
        await sub.cancel();

        // Assert
        expect(emitted, hasLength(1));
        final updated = emitted.first;
        expect(updated.selectedTabIndex, 2);
        expect(updated.occasions, hasLength(1));
      },
    );

    // -----------------------------------------------------------------------
    // selectTab — no-op when not in success state
    // Verifies SelectTabIntent does nothing when called before occasions are loaded.
    // -----------------------------------------------------------------------
    test(
      'SelectTabIntent is a no-op when state status is not success',
      () async {
        // Arrange — cubit is in OccasionStatus.initial
        final emitted = <OccasionState>[];
        final sub = cubit.stream.listen(emitted.add);

        // Act
        cubit.handleIntent(const SelectTabIntent(1));
        await Future<void>.delayed(Duration.zero);
        await sub.cancel();

        // Assert — no new state was emitted
        expect(emitted, isEmpty);
      },
    );
  });
}
